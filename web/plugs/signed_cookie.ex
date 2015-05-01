defmodule CedaRealty.Plugs.SignedCookie do
  @moduledoc """
  Provides functions for storing signed and optionally encrypted cookies.

  Most of the code for this module was stolen from the following:

    * https://github.com/elixir-lang/plug/blob/master/lib/plug/conn.ex
    * https://github.com/elixir-lang/plug/blob/master/lib/plug/session/cookie.ex
  """

  alias Plug.Conn

  @doc """
  Puts a signed and optionally encrypted response cookie.

  ## Options

    * `:domain` - the domain the cookie applies to
    * `:max_age` - the cookie max-age
    * `:path` - the path the cookie applies to
    * `:http_only` - when false, the cookie is accessible beyond http
    * `:secure` - if the cookie must be sent only over https. Defaults
      to true when the connection is https
    * `:encryption_salt` - a salt used with `conn.secret_key_base` to generate
      a key for encrypting/decrypting a cookie.
    * `:key_iterations` - option passed to `Plug.Crypto.KeyGenerator`
      when generating the encryption and signing keys. Defaults to 1000;
    * `:key_length` - option passed to `Plug.Crypto.KeyGenerator`
      when generating the encryption and signing keys. Defaults to 32;
    * `:key_digest` - option passed to `Plug.Crypto.KeyGenerator`
      when generating the encryption and signing keys. Defaults to `:sha256';
    * `:serializer` - cookie serializer module that defines `encode/1` and
      `decode/1` returning an `{:ok, value}` tuple. Defaults to
      `:external_term_format`.
  """

  def put_signed_resp_cookie(%Conn{resp_cookies: _resp_cookies, scheme: _scheme} = conn, key, value, signing_salt, opts \\ []) when
      is_binary(key) and is_binary(signing_salt) and is_list(opts) do
    encryption_salt = opts[:encryption_salt]

    iterations = Keyword.get(opts, :key_iterations, 1000)

    length = Keyword.get(opts, :key_length, 32)

    digest = Keyword.get(opts, :key_digest, :sha256)

    key_opts = [iterations: iterations,
                length: length,
                digest: digest,
                cache: Plug.Keys]

    serializer = check_serializer(opts[:serializer] || :external_term_format)

    binary = encode(value, serializer)

    signing_secret = derive(conn, signing_salt, key_opts)

    encryption_secret = derive(conn, encryption_salt, key_opts)

    conn
    |> Plug.Conn.put_resp_cookie(key, encrypt_and_sign(binary, encryption_secret, signing_secret), Keyword.drop(opts, [:encryption_salt, :key_iterations, :key_length, :key_digest, :serializer]))
  end

  def get_signed_cookie(conn, key, signing_salt, opts \\ []) when
      is_binary(key) and is_binary(signing_salt) and is_list(opts) do
    conn = conn |> Plug.Conn.fetch_cookies

    binary = conn.cookies[key]

    if binary do
      encryption_salt = opts[:encryption_salt]

      iterations = Keyword.get(opts, :key_iterations, 1000)

      length = Keyword.get(opts, :key_length, 32)

      digest = Keyword.get(opts, :key_digest, :sha256)

      key_opts = [iterations: iterations,
                  length: length,
                  digest: digest,
                  cache: Plug.Keys]

      serializer = check_serializer(opts[:serializer] || :external_term_format)

      signing_secret = derive(conn, signing_salt, key_opts)

      encryption_secret = derive(conn, encryption_salt, key_opts)

      verify_and_decrypt(binary, encryption_secret, signing_secret)
      |> decode(serializer)
    else
      {:error, nil}
    end
  end

  defp encode(term, :external_term_format) do
    :erlang.term_to_binary(term)
  end

  defp encode(term, serializer) do
    case serializer.encode(term) do
      {:ok, binary} -> binary
      _ -> nil
    end
  end

  defp decode({:ok, binary}, :external_term_format) do
    {nil, :erlang.binary_to_term(binary)}
  end

  defp decode({:ok, binary}, serializer) do
    case serializer.decode(binary) do
      {:ok, term} -> {nil, term}
      _ -> {nil, %{}}
    end
  end

  defp decode(:error, _serializer) do
    {nil, %{}}
  end

  defp derive(_conn, nil, _key_opts) do
    nil
  end

  defp derive(conn, key, key_opts) do
    conn.secret_key_base
    |> validate_secret_key_base()
    |> Plug.Crypto.KeyGenerator.generate(key, key_opts)
  end

  defp encrypt_and_sign(binary, nil, signing_secret) do
    Plug.Crypto.MessageVerifier.sign(binary, signing_secret)
  end

  defp encrypt_and_sign(binary, encryption_secret, signing_secret) do
    Plug.Crypto.MessageEncryptor.encrypt_and_sign(binary, encryption_secret, signing_secret)
  end

  defp verify_and_decrypt(value, nil, signing_secret) do
    Plug.Crypto.MessageVerifier.verify(value, signing_secret)
  end

  defp verify_and_decrypt(value, encryption_secret, signing_secret) do
    Plug.Crypto.MessageEncryptor.verify_and_decrypt(value, encryption_secret, signing_secret)
  end

  defp validate_secret_key_base(nil) do
    raise(ArgumentError, "signed cookies expect conn.secret_key_base to be set")
  end

  defp validate_secret_key_base(secret_key_base) when byte_size(secret_key_base) < 64 do
    raise(ArgumentError, "signed cookies expect conn.secret_key_base to be at least 64 bytes")
  end

  defp validate_secret_key_base(secret_key_base) do
    secret_key_base
  end

  defp check_serializer(serializer) when is_atom(serializer) do
    serializer
  end

  defp check_serializer(_) do
    raise(ArgumentError, "signed cookies expect :serializer option to be a module")
  end
end

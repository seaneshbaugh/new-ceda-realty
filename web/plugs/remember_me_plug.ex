defmodule CedaRealty.Plugs.RememberMePlug do
  import Plug.Conn
  #  use CedaRealty.Web, :controller
  import Ecto.Query

  def init(default) do
    default
  end

  def call(conn, _) do
    conn = fetch_session(conn)

    if !is_logged_in(get_session(conn, :current_user)) do
      conn = conn |> fetch_cookies

      remember_me_token = conn.cookies["remember_me_token"]

      if remember_me_token do
        encryption_salt = "VzQ0Tr91lVVJ2yPF"

        signing_salt = "deW9u3bUcbyz6fik"

        iterations = 1000

        length = 32

        digest = :sha256

        key_opts = [iterations: iterations,
                    length: length,
                    digest: digest,
                    cache: Plug.Keys]

        {:ok, value} = Plug.Crypto.MessageEncryptor.verify_and_decrypt(remember_me_token, derive(conn, encryption_salt, key_opts), derive(conn, signing_salt, key_opts))

        id = value |> :erlang.binary_to_term

        query = from user in CedaRealty.User, where: user.id == ^id

        user = CedaRealty.Repo.all(query) |> List.first

        if user do
          put_session(conn, :current_user, user)
        else
          conn
        end
      else
        conn
      end
    else
      conn
    end
  end

  def is_logged_in(user_session) do
    case user_session do
      nil -> false
      _ -> true
    end
  end

  defp derive(conn, key, key_opts) do
    conn.secret_key_base
    |> Plug.Crypto.KeyGenerator.generate(key, key_opts)
  end
end

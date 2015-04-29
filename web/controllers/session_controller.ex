defmodule CedaRealty.SessionController do
  use CedaRealty.Web, :controller
  import Comeonin.Bcrypt

  plug :action

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    username = params["user"]["username"]

    password = params["user"]["password"]

    query = from user in CedaRealty.User, where: user.username == ^username

    user = CedaRealty.Repo.all(query) |> List.first

    if !(is_nil user) do
      if checkpw(password, user.encrypted_password) do
        conn
        |> fetch_session
        |> put_session(:current_user, user)
        |> remember_me(params)
        |> put_flash(:info, "Successfully logged in.")
        |> redirect(to: page_path(conn, :index))
      else
        conn
        |> put_flash(:error, "Invalid username or password.")
        |> redirect(to: session_path(conn, :new))
      end
    else
      dummy_checkpw

      conn
      |> put_flash(:error, "Invalid username or password")
      |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    if conn.assigns[:current_user] do
      conn
      |> fetch_session
      |> put_session(:current_user, nil)
      |> delete_resp_cookie("remember_me_token")
      |> put_flash(:info, "Successfully logged out.")
      |> redirect(to: session_path(conn, :new))
    else
      conn
      |> put_flash(:info, "You are not logged in.")
      |> redirect(to: session_path(conn, :new))
    end
  end

  defp remember_me(conn, params) do
    if params["user"]["remember_me"] do
      encryption_salt = "VzQ0Tr91lVVJ2yPF"

      signing_salt = "deW9u3bUcbyz6fik"

      iterations = 1000

      length = 32

      digest = :sha256

      key_opts = [iterations: iterations,
                  length: length,
                  digest: digest,
                  cache: Plug.Keys]

      binary = :erlang.term_to_binary(get_session(conn, :current_user).id)

      value = Plug.Crypto.MessageEncryptor.encrypt_and_sign(binary, derive(conn, encryption_salt, key_opts), derive(conn, signing_salt, key_opts))

      conn
      |> Plug.Conn.put_resp_cookie("remember_me_token", value, [max_age: 60 * 60 * 24 * 365 * 10])
    else
      conn
    end
  end

  defp derive(conn, key, key_opts) do
    conn.secret_key_base
    |> Plug.Crypto.KeyGenerator.generate(key, key_opts)
  end
end

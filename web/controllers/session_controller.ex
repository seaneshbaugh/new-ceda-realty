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

    user = CedaRealty.Repo.one(from user in CedaRealty.user, where: user.username == ^username)

    if user do
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
      |> delete_resp_cookie(CedaRealty.Endpoint.config(:remember_me, [])[:key])
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
      key = CedaRealty.Endpoint.config(:remember_me, [])[:key]

      signing_salt = CedaRealty.Endpoint.config(:remember_me, [])[:signing_salt]

      encryption_salt = CedaRealty.Endpoint.config(:remember_me,[])[:encryption_salt]

      max_age = 60 * 60 * 24 * 365 * 10

      conn
      |> CedaRealty.Plugs.SignedCookie.put_signed_resp_cookie(key, get_session(conn, :current_user).id, signing_salt, [encryption_salt: encryption_salt, max_age: max_age])
    else
      conn
    end
  end
end

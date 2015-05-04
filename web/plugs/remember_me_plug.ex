defmodule CedaRealty.Plugs.RememberMePlug do
  @moduledoc """
  A plug that checks for a _remember_me_token cookie and adds the corresponding user to the session if found.
  """

  import Plug.Conn
  import Ecto.Query

  @behaviour Plug

  def init(default) do
    default
  end

  def call(conn, config) do
    conn
    |> fetch_session
    |> set_current_user_from_cookie(config[:key], config[:signing_salt], [encryption_salt: config[:encryption_salt]])
  end

  defp set_current_user_from_cookie(conn, key, signing_salt, opts) do
    if !get_session(conn, :current_user) do
      conn
      |> fetch_cookies
      |> set_current_user(CedaRealty.Plugs.SignedCookie.get_signed_cookie(conn, key, signing_salt, opts))
    else
      conn
    end
  end

  defp set_current_user(conn, {_, nil}) do
    conn
  end

  defp set_current_user(conn, {_, id}) do
    user = CedaRealty.Repo.one(from user in CedaRealty.User, where: user.id == ^id)

    conn
    |> put_session(:current_user, user)
  end
end

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
    conn = fetch_session(conn) |> fetch_cookies

    {_, id} = CedaRealty.Plugs.SignedCookie.get_signed_cookie(conn, config[:key], config[:signing_salt], [encryption_salt: config[:encryption_salt]])

    if id do
      user = CedaRealty.Repo.one(from user in CedaRealty.User, where: user.id == ^id)

      if user do
        put_session(conn, :current_user, user)
      else
        conn
      end
    else
      conn
    end
  end
end

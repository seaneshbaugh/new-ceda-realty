defmodule CedaRealty.Plugs.SetCurrentUser do
  import Plug.Conn
  import Ecto.Query

  def init(default) do
    default
  end

  def call(conn, _) do
    conn = fetch_session(conn)

    current_user = get_session(conn, :current_user)

    if current_user do
      user = CedaRealty.Repo.one(from user in CedaRealty.User, where: user.id == ^current_user.id)

      # The user is put back in the session so changes in the database are reflected.
      conn
      |> put_session(:current_user, user)
      |> assign(:current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end

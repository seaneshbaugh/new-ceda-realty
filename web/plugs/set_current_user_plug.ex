defmodule CedaRealty.Plugs.SetCurrentUser do
  import Plug.Conn
  import Ecto.Query

  def init(default) do
    default
  end

  def call(conn, _) do
    conn = fetch_session(conn)

    current_user = get_session(conn, :current_user)

    if is_logged_in(current_user) do
      user = CedaRealty.Repo.one(from user in CedaRealty.User, where: user.id == ^current_user.id)

      if user do
        assign(conn, :current_user, get_session(conn, :current_user))
      else
        assign(conn, :current_user, nil)
      end
    else
      assign(conn, :current_user, nil)
    end
  end

  def is_logged_in(user_session) do
    case user_session do
      nil -> false
      _ -> true
    end
  end
end

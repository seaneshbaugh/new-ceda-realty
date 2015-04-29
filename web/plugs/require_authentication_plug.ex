defmodule CedaRealty.Plugs.RequireAuthentication do
  import Plug.Conn
  use Phoenix.Controller

  def init(default) do
    default
  end

  def call(conn, _) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to view this page.")
      |> redirect(to: "/login")
      |> halt
    end
  end
end

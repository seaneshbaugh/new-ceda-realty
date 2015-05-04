defmodule CedaRealty.Plugs.RequireAuthorization do
  import Plug.Conn
  use Phoenix.Controller

  def init(default) do
    default
  end

  def call(conn, _) do
    if conn.assigns.authorized do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorizaed to view this page.")
      |> redirect(to: "/")
      |> halt
    end
  end
end

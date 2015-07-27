defmodule CedaRealty.Admin.AdminController do
  use CedaRealty.Web, :controller

  plug CedaRealty.Plugs.RequireAuthentication
  plug :authorize_resource, model: CedaRealty.Admin
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end

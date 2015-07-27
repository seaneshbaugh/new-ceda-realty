defmodule CedaRealty.Agents.AgentsController do
  use CedaRealty.Web, :controller

  plug CedaRealty.Plugs.RequireAuthentication
  plug :authorize_resource, model: CedaRealty.Agents
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "agents.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end

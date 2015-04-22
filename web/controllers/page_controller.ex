defmodule CedaRealty.PageController do
  use CedaRealty.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end

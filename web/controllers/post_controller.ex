defmodule CedaRealty.PostController do
  use CedaRealty.Web, :controller
  alias CedaRealty.Post

  def index(conn, _params) do
    posts = CedaRealty.Repo.all(Post)

    render conn, "index.html", posts: posts
  end
end

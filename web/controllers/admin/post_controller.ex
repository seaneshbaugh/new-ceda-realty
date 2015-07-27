defmodule CedaRealty.Admin.PostController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Post

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "post" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Post
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", posts: conn.assigns.posts
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{}, :create)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, :create, Map.put(post_params, "user_id", conn.assigns.current_user.id))

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Post created successfully.")
      |> redirect(to: admin_post_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, _params) do
    render conn, "show.html", post: conn.assigns.post |> CedaRealty.Repo.preload(:user)
  end

  def edit(conn, _params) do
    post = conn.assigns.post

    changeset = Post.changeset(post, :update)

    render conn, "edit.html", post: post, changeset: changeset
  end

  def update(conn, %{"post" => post_params}) do
    post = conn.assigns.post

    changeset = Post.changeset(post, :update, post_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Post updated successfully.")
      |> redirect(to: admin_post_path(conn, :index))
    else
      render conn, "edit.html", post: post, changeset: changeset
    end
  end

  def delete(conn, _params) do
    post = conn.assigns.post

    Repo.delete(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: admin_post_path(conn, :index))
  end
end

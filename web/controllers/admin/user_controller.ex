defmodule CedaRealty.Admin.UserController do
  use CedaRealty.Web, :controller

  alias CedaRealty.User

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "user" when action in [:create, :update]
  plug :load_and_authorize_resource, model: User
  plug CedaRealty.Plugs.RequireAuthorization
  plug :action

  def index(conn, _params) do
    render conn, "index.html", users: conn.assigns.loaded_resource
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, :create)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, :create, user_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: admin_user_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", user: conn.assigns.loaded_resource
  end

  def edit(conn, %{"id" => id}) do
    user = conn.assigns.loaded_resource

    changeset = User.changeset(user, :update)

    render conn, "edit.html", user: user, changeset: changeset
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = conn.assigns.loaded_resource

    changeset = User.changeset(user, :update, user_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: admin_user_path(conn, :index))
    else
      render conn, "edit.html", user: user, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    user = conn.assigns.loaded_resource

    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_user_path(conn, :index))
  end
end

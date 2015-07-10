defmodule CedaRealty.Admin.PageController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Page

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "page" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Page
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", pages: conn.assigns.pages
  end

  def new(conn, _params) do
    changeset = Page.changeset(%Page{}, :create)

    render conn, "new.html", changeset: changeset, pages: CedaRealty.Repo.all(CedaRealty.Page)
  end

  def create(conn, %{"page" => page_params}) do
    changeset = Page.changeset(%Page{}, :create, page_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Page created successfully.")
      |> redirect(to: admin_page_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", page: conn.assigns.page |> CedaRealty.Repo.preload(:parent)
  end

  def edit(conn, %{"id" => id}) do
    page = conn.assigns.page

    changeset = Page.changeset(page, :update)

    render conn, "edit.html", page: page, changeset: changeset, pages: CedaRealty.Repo.all(CedaRealty.Page)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = conn.assigns.page

    changeset = Page.changeset(page, :update, page_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Page updated successfully.")
      |> redirect(to: admin_page_path(conn, :index))
    else
      render conn, "edit.html", page: page, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    page = conn.assigns.page

    Repo.delete(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: admin_page_path(conn, :index))
  end
end

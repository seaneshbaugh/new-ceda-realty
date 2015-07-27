defmodule CedaRealty.Admin.OfficeController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Office

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "office" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Office
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", offices: conn.assigns.offices
  end

  def new(conn, _params) do
    changeset = Office.changeset(%Office{}, :create)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"office" => office_params}) do
    changeset = Office.changeset(%Office{}, :create, office_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      Office.save_picture!(changeset, office_params)

      conn
      |> put_flash(:info, "Office created successfully.")
      |> redirect(to: admin_office_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, _params) do
    render conn, "show.html", office: conn.assigns.office |> CedaRealty.Repo.preload(:manager)
  end

  def edit(conn, _params) do
    changeset = Office.changeset(conn.assigns.office, :update)

    render conn, "edit.html", office: conn.assigns.office, changeset: changeset
  end

  def update(conn, %{"office" => office_params}) do
    changeset = Office.changeset(conn.assigns.office, :update, office_params)

    if changeset.valid? do
      Repo.update!(changeset)

      Office.replace_picture!(changeset, office_params)

      conn
      |> put_flash(:info, "Office updated successfully.")
      |> redirect(to: admin_office_path(conn, :index))
    else
      render conn, "edit.html", office: conn.assigns.office, changeset: changeset
    end
  end

  def delete(conn, _params) do
    Repo.delete!(conn.assigns.office)

    Office.delete_picture!(conn.assigns.office)

    conn
    |> put_flash(:info, "Office deleted successfully.")
    |> redirect(to: admin_office_path(conn, :index))
  end
end

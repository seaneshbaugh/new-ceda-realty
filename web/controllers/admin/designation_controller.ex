defmodule CedaRealty.Admin.DesignationController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Designation

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "designation" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Designation
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", designations: conn.assigns.designations
  end

  def new(conn, _params) do
    changeset = Designation.changeset(%Designation{}, :create)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"designation" => designation_params}) do
    changeset = Designation.changeset(%Designation{}, :create, designation_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      Designation.save_logo!(changeset, designation_params)

      conn
      |> put_flash(:info, "Designation created successfully.")
      |> redirect(to: admin_designation_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, _params) do
    render conn, "show.html", designation: conn.assigns.designation
  end

  def edit(conn, _params) do
    designation = conn.assigns.designation

    changeset = Designation.changeset(designation, :update)

    render conn, "edit.html", designation: designation, changeset: changeset
  end

  def update(conn, %{"designation" => designation_params}) do
    designation = conn.assigns.designation

    changeset = Designation.changeset(designation, :update, designation_params)

    if changeset.valid? do
      Repo.update!(changeset)

      Office.replace_logo!(changeset, designation_params)

      conn
      |> put_flash(:info, "Designation updated successfully.")
      |> redirect(to: admin_designation_path(conn, :index))
    else
      render conn, "edit.html", designation: designation, changeset: changeset
    end
  end

  def delete(conn, _params) do
    Repo.delete!(conn.assigns.designation)

    Designation.delete_logo!(conn.assigns.designation)

    conn
    |> put_flash(:info, "Designation deleted successfully.")
    |> redirect(to: admin_designation_path(conn, :index))
  end
end

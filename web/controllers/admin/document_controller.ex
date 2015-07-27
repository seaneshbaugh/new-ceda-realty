defmodule CedaRealty.Admin.DocumentController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Document

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "document" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Document
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", documents: conn.assigns.documents
  end

  def new(conn, _params) do
    changeset = Document.changeset(%Document{}, :create)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"document" => document_params}) do
    changeset = Document.changeset(%Document{}, :create, document_params)

#    IO.inspect document_params

    if changeset.valid? do
      Repo.insert!(changeset)

      Document.save_file!(changeset, document_params)

      conn
      |> put_flash(:info, "Document created successfully.")
      |> redirect(to: admin_document_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => _id}) do
    render conn, "show.html", document: conn.assigns.document
  end

  def edit(conn, _params) do
    changeset = Document.changeset(conn.assigns.document, :update)

    render conn, "edit.html", document: conn.assigns.document, changeset: changeset
  end

  def update(conn, %{"document" => document_params}) do
    changeset = Document.changeset(conn.assigns.document, :update, document_params)

    if changeset.valid? do
      Repo.update!(changeset)

      Document.replace_file!(changeset, document_params)

      conn
      |> put_flash(:info, "Document updated successfully.")
      |> redirect(to: admin_document_path(conn, :index))
    else
      render conn, "edit.html", document: conn.assigns.document, changeset: changeset
    end
  end

  def delete(conn, %{"id" => _id}) do
    document = conn.assigns.document

    Repo.delete!(document)

    Document.delete_file!(document)

    conn
    |> put_flash(:info, "Document deleted successfully.")
    |> redirect(to: admin_document_path(conn, :index))
  end
end

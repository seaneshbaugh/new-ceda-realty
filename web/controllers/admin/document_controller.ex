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
    changeset = Document.changeset(%Document{}, :new)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"document" => document_params}) do
    changeset = Document.changeset(%Document{}, :create, document_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      documents_path = Path.expand("./priv/static/system/documents")

      File.mkdir_p!(documents_path)

      document_path = Path.join(documents_path, Ecto.Changeset.get_field(changeset, :file_path))

      File.cp!(document_params["file"].path, document_path)

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

  def delete(conn, %{"id" => _id}) do
    document = conn.assigns.document

    Repo.delete(document)

    document_path = Path.join(Path.expand("./priv/static/system/documents"), document.file_path)

    File.rm!(document_path)

    conn
    |> put_flash(:info, "Document deleted successfully.")
    |> redirect(to: admin_document_path(conn, :index))
  end
end

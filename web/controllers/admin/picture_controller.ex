defmodule CedaRealty.Admin.PictureController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Picture

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "picture" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Picture
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", pictures: conn.assigns.pictures
  end

  def new(conn, _params) do
    changeset = Picture.changeset(%Picture{}, :new)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"picture" => picture_params}) do
    changeset = Picture.changeset(%Picture{}, :create, picture_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      pictures_path = Path.expand("./priv/static/system/pictures")

      File.mkdir_p!(pictures_path)

      picture_path = Path.join(pictures_path, Ecto.Changeset.get_field(changeset, :file_path))

      File.cp!(picture_params["file"].path, picture_path)

      parts = String.split(picture_path, ".")

      thumbnail_path = Enum.join(Enum.take(parts, length(parts) - 1), ".") <> "_thumbnail." <> List.first(Enum.take(parts, -1))

      Mogrify.open(picture_path) |> Mogrify.copy |> Mogrify.resize("100x100>") |> Mogrify.save(thumbnail_path)

      conn
      |> put_flash(:info, "Picture created successfully.")
      |> redirect(to: admin_picture_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", picture: conn.assigns.picture
  end

  def delete(conn, %{"id" => id}) do
    picture = conn.assigns.picture

    Repo.delete(picture)

    picture_path = Path.join(Path.expand("./priv/static/system/pictures"), picture.file_path)

    File.rm!(picture_path)

    parts = String.split(picture_path, ".")

    thumbnail_path = Enum.join(Enum.take(parts, length(parts) - 1), ".") <> "_thumbnail." <> List.first(Enum.take(parts, -1))

    File.rm!(thumbnail_path)

    conn
    |> put_flash(:info, "Picture deleted successfully.")
    |> redirect(to: admin_picture_path(conn, :index))
  end
end

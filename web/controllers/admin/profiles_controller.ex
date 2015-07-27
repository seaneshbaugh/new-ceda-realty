defmodule CedaRealty.Admin.ProfileController do
  use CedaRealty.Web, :controller

  alias CedaRealty.Profile

  plug CedaRealty.Plugs.RequireAuthentication
  plug :scrub_params, "profile" when action in [:create, :update]
  plug :load_and_authorize_resource, model: Profile
  plug CedaRealty.Plugs.RequireAuthorization
  plug :put_layout, "admin.html"

  def index(conn, _params) do
    render conn, "index.html", profiles: conn.assigns.profiles
  end

  def new(conn, _params) do
    changeset = Profile.changeset(%Profile{}, :create)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"profile" => profile_params}) do
    changeset = Profile.changeset(%Profile{}, :create, profile_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      Profile.save_picture!(changeset, profile_params)

      conn
      |> put_flash(:info, "Profile created successfully.")
      |> redirect(to: admin_profile_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, _params) do
    render conn, "show.html", profile: conn.assigns.profile |> CedaRealty.Repo.preload(:manager)
  end

  def edit(conn, _params) do
    changeset = Profile.changeset(conn.assigns.profile, :update)

    render conn, "edit.html", profile: conn.assigns.profile, changeset: changeset
  end

  def update(conn, %{"profile" => profile_params}) do
    changeset = Profile.changeset(conn.assigns.profile, :update, profile_params)

    if changeset.valid? do
      Repo.update!(changeset)

      Profile.replace_picture!(changeset, profile_params)

      conn
      |> put_flash(:info, "Profile updated successfully.")
      |> redirect(to: admin_profile_path(conn, :index))
    else
      render conn, "edit.html", profile: conn.assigns.profile, changeset: changeset
    end
  end

  def delete(conn, _params) do
    Repo.delete!(conn.assigns.profile)

    Profile.delete_picture!(conn.assigns.profile)

    conn
    |> put_flash(:info, "Profile deleted successfully.")
    |> redirect(to: admin_profile_path(conn, :index))
  end
end

defmodule CedaRealty.Directory do
  use CedaRealty.Web, :model

  schema "directories" do
    field :name, :string, default: ""
    field :slug, :string, default: ""
    field :full_path, :string, default: ""

    belongs_to :parent, CedaRealty.Directory
    belongs_to :user, CedaRealty.User
    belongs_to :office, CedaRealty.Office
    has_many :children, CedaRealty.Directory, on_delete: :delete_all
    has_many :documents, CedaRealty.Directory, on_delete: :delete_all

    timestamps
  end

  def changeset(model, action, params \\ :empty)

  def changeset(model, :new, _params) do
    model
    |> cast(:empty, ~w(), ~w())
  end

  def changeset(model, action, params) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_slug
    |> set_full_path
    |> validate_length(:name, min: 3)
    |> validate_length(:name, max: 64)
  end

  defp required_fields_for(:create) do
    ~w(name)
  end

  defp required_fields_for(:update) do
    ~w(name)
  end

  defp optional_fields_for(:create) do
    ~w(parent_id user_id office_id)
  end

  defp optional_fields_for(:update) do
    ~w()
  end

  defp set_slug(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(name || ""))
  end

  defp set_full_path(changeset) do
    slug = Ecto.Changeset.get_field(changeset, :slug)

    parent_id = Ecto.Changeset.get_field(changeset, :parent_id)

    if parent_id do
      parent = CedaRealty.Repo.one(from directory in CedaRealty.Directory, where: directory.id == ^parent_id)

      if parent do
        Ecto.Changeset.put_change(changeset, :full_path, parent.full_path <> "/" <> slug)
      else
        Ecto.Changeset.add_error(changeset, :parent_id, "is not a valid directory")
      end
    else
      Ecto.Changeset.put_change(changeset, :full_path, "/" <> slug)
    end
  end
end

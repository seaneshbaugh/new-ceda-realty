defmodule CedaRealty.Document do
  use CedaRealty.Web, :model
  use CedaRealty.Concerns.HasAttachment, :file

  schema "documents" do
    field :name, :string, default: ""
    field :slug, :string, default: ""
    field :file_path, :string, default: ""
    field :file_file_size, :integer, default: 0
    field :file_file_content_type, :string, default: ""
    field :file_original_file_name, :string, default: ""
    field :file_checksum, :string, default: ""

    belongs_to :directory, CedaRealty.Directory
    belongs_to :user, CedaRealty.User
    belongs_to :office, CedaRealty.Office

    timestamps
  end

  def changeset(model, action, params \\ :empty) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_file_attributes(params)
    |> set_slug
    |> validate_unique(:file_checksum, on: CedaRealty.Repo)
  end

  defp required_fields_for(:create) do
    ~w(name)
  end

  defp required_fields_for(:update) do
    ~w(name)
  end

  defp optional_fields_for(:create) do
    ~w()
  end

  defp optional_fields_for(:update) do
    ~w()
  end

  defp set_slug(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(name || ""))
  end
end

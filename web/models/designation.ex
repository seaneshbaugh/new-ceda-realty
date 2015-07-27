defmodule CedaRealty.Designation do
  use CedaRealty.Web, :model
  use CedaRealty.Concerns.HasAttachment, :logo

  schema "designations" do
    field :name, :string, default: ""
    field :slug, :string, default: ""
    field :abbreviation, :string, default: ""
    field :description, :string, default: ""
    field :logo_path, :string, default: ""
    field :logo_file_size, :integer, default: 0
    field :logo_file_content_type, :string, default: ""
    field :logo_original_file_name, :string, default: ""
    field :logo_checksum, :string, default: ""
    field :visible, :boolean, default: true

    has_many :designations_profiles, CedaRealty.DesignationProfile
    has_many :profiles, through: [:designations_profiles, :profile]

    timestamps
  end

  def changeset(model, action, params \\ :empty) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_logo_attributes(params)
    |> set_slug
    |> validate_length(:name, min: 1)
    |> validate_length(:name, max: 255)
  end

  defp required_fields_for(:create) do
    ~w(name abbreviation visible)
  end

  defp required_fields_for(:update) do
    ~w(name abbreviation visible)
  end

  defp optional_fields_for(:create) do
    ~w(description)
  end

  defp optional_fields_for(:update) do
    ~w(description)
  end

  defp set_slug(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(name || ""))
  end
end

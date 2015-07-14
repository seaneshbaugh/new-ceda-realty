defmodule CedaRealty.Document do
  use CedaRealty.Web, :model
  import CedaRealty.Concerns.DefaultValues

  schema "documents" do
    field :name, :string
    field :slug, :string
    field :file_path, :string
    field :file_size, :integer
    field :file_content_type, :string
    field :file_original_file_name, :string
    field :file_checksum, :string

    belongs_to :directory, CedaRealty.Directory
    belongs_to :user, CedaRealty.User
    # belongs_to :office, CedaRealty.Office

    timestamps
  end

  def changeset(model, action, params \\ :empty)

  def changeset(model, :new, _params) do
    model
    |> cast(:empty, ~w(), ~w())
  end

  def changeset(model, :create, params) do
    model
    |> cast(params, required_fields_for(:create), optional_fields_for(:create))
    |> set_file_attributes(params["file"])
    |> validate_unique(:file_checksum, on: CedaRealty.Repo)
  end

  def changeset(model, :update, params) do
    model
    |> cast(params, required_fields_for(:update), optional_fields_for(:update))
    |> set_file_attributes(params["file"])
    |> validate_unique(:file_checksum, on: CedaRealty.Repo)
  end

  defp required_fields_for(:create) do
    ~w(:name)
  end

  defp optional_fields_for(:create) do
    ~w(:name)
  end

  defp set_file_attributes(changeset, file) do
    file_size = File.stat!(file.path).size

    file_checksum = :crypto.hash(:sha512, File.read!(file.path)) |> Base.encode16 |> String.downcase

    file_extension = Path.extname(file.filename)
    |> String.downcase
    |> String.replace(~r/\.jpeg$/, ".jpg")
    |> String.replace(~r/\.mpg$/, ".mpeg")
    |> String.replace(~r/\.tif$/, ".tiff")
    |> String.replace(~r/\.markdown$/, ".md")

    file_path = file_checksum <> file_extension

    changeset
    |> Ecto.Changeset.put_change(:file_path, file_path)
    |> Ecto.Changeset.put_change(:file_size, file_size)
    |> Ecto.Changeset.put_change(:file_content_type, file.content_type)
    |> Ecto.Changeset.put_change(:file_original_file_name, file.filename)
    |> Ecto.Changeset.put_change(:file_checksum, file_checksum)
  end
end

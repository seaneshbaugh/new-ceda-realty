defmodule CedaRealty.Picture do
  use CedaRealty.Web, :model

  schema "pictures" do
    field :file_path, :string, default: ""
    field :file_size, :integer, default: 0
    field :file_content_type, :string, default: ""
    field :file_original_file_name, :string, default: ""
    field :file_checksum, :string, default: ""

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
    |> validate_file_content_type
  end

  defp required_fields_for(:create) do
    ~w()
  end

  defp optional_fields_for(:create) do
    ~w()
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

  def validate_file_content_type(changeset) do
    if !String.match?(Ecto.Changeset.get_field(changeset, :file_content_type), ~r/^image/) do
      add_error(changeset, :file_content_type, "is not an image")
    else
      changeset
    end
  end
end

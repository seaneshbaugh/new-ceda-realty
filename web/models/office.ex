defmodule CedaRealty.Office do
  use CedaRealty.Web, :model
  use CedaRealty.Concerns.HasAttachment, [name: :picture, styles: %{thumbnail: fn file -> file |> Mogrify.resize("100x100>") end}]

  schema "offices" do
    field :picture_path, :string, default: ""
    field :picture_file_size, :integer, default: 0
    field :picture_file_content_type, :string, default: ""
    field :picture_original_file_name, :string, default: ""
    field :picture_checksum, :string, default: ""
    field :name, :string, default: ""
    field :slug, :string, default: ""
    field :street_address_1, :string, default: ""
    field :street_address_2, :string, default: ""
    field :city, :string, default: ""
    field :state, :string, default: ""
    field :zipcode, :string, default: ""
    field :phone_number, :string, default: ""
    field :fax_number, :string, default: ""
    field :description_body, :string, default: ""
    field :description_style, :string, default: ""
    field :description_script, :string, default: ""
    field :meta_description, :string, default: ""
    field :google_maps_uri, :string, default: ""
    field :visible, :boolean, default: true

    belongs_to :manager, CedaRealty.User

    timestamps
  end

  def changeset(model, action, params \\ :empty) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_picture_attributes(params)
    |> set_slug
    |> validate_length(:name, min: 3)
    |> validate_length(:name, max: 64)
  end

  # def save_picture!(office, %{"picture" => %{path: temp_path}}) do
  #   path = picture_path(office)

  #   if path do
  #     File.mkdir_p!(pictures_path)

  #     File.cp!(temp_path, path)
  #   end
  # end

  # def save_picture!(_changeset, _params) do
  # end

  # def delete_picture!(%Ecto.Changeset{changes: _changes, model: office}) do
  #   path = picture_path(office)

  #   if path do
  #     File.rm!(path)
  #   end
  # end

  # def delete_picture!(office) do
  #   path = picture_path(office)

  #   if path do
  #     File.rm!(path)
  #   end
  # end

  # def replace_picture!(office, params) do
  #   delete_picture!(office)

  #   save_picture!(office, params)
  # end

  defp required_fields_for(:create) do
    ~w(name)
  end

  defp required_fields_for(:update) do
    ~w()
  end

  defp optional_fields_for(:create) do
    ~w(name)
  end

  defp optional_fields_for(:update) do
    ~w()
  end

  # defp pictures_path do
  #   Path.expand("./priv/static/system/offices/pictures")
  # end

  # defp picture_path(%Ecto.Changeset{changes: _changes, model: _model} = changeset) do
  #   path = Ecto.Changeset.get_field(changeset, :picture_path)

  #   case path do
  #     nil -> nil
  #     _ -> Path.join(pictures_path, path)
  #   end
  # end

  # defp picture_path(%{picture_path: nil}) do
  #   nil
  # end

  # defp picture_path(%{picture_path: ""}) do
  #   nil
  # end

  # defp picture_path(%{picture_path: path}) do
  #   Path.join(pictures_path, path)
  # end

  # defp picture_path(_office) do
  #   nil
  # end

  # defp set_picture_attributes(changeset, :empty) do
  #   changeset
  # end

  # defp set_picture_attributes(changeset, %{"picture" => picture} = _params) do
  #   file_size = File.stat!(picture.path).size

  #   file_checksum = :crypto.hash(:sha512, File.read!(picture.path)) |> Base.encode16 |> String.downcase

  #   file_extension = Path.extname(picture.filename)
  #   |> String.downcase
  #   |> String.replace(~r/\.jpeg$/, ".jpg")
  #   |> String.replace(~r/\.mpg$/, ".mpeg")
  #   |> String.replace(~r/\.tif$/, ".tiff")
  #   |> String.replace(~r/\.markdown$/, ".md")

  #   file_path = file_checksum <> file_extension

  #   changeset
  #   |> Ecto.Changeset.put_change(:picture_path, file_path)
  #   |> Ecto.Changeset.put_change(:picture_file_size, file_size)
  #   |> Ecto.Changeset.put_change(:picture_content_type, picture.content_type)
  #   |> Ecto.Changeset.put_change(:picture_original_file_name, picture.filename)
  #   |> Ecto.Changeset.put_change(:picture_checksum, file_checksum)
  # end

  # defp set_picture_attributes(changeset, _params) do
  #   changeset
  # end

  defp set_slug(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(name || ""))
  end
end

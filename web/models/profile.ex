defmodule CedaRealty.Profile do
  use CedaRealty.Web, :model
  use CedaRealty.Concerns.HasAttachment, [name: :picture, styles: %{thumbnail: fn file -> file |> Mogrify.resize("100x100>") end}]

  schema "profiles" do
    field :picture_path, :string, default: ""
    field :picture_file_size, :integer, default: 0
    field :picture_file_content_type, :string, default: ""
    field :picture_original_file_name, :string, default: ""
    field :picture_checksum, :string, default: ""
    field :display_name, :string, default: ""
    field :slug, :string, default: ""
    field :title, :string, default: ""
    field :first_name, :string, default: ""
    field :last_name, :string, default: ""
    field :display_email_address, :string, default: ""
    field :phone_number, :string, default: ""
    field :website_uri, :string, default: ""
    field :facebook_uri, :string, default: ""
    field :twitter_username, :string, default: ""
    field :linked_in_uri, :string, default: ""
    field :active_rain_uri, :string, default: ""
    field :youtube_uri, :string, default: ""
    field :instagram_uri, :string, default: ""
    field :bio_body, :string, default: ""
    field :bio_style, :string, default: ""
    field :bio_script, :string, default: ""
    field :meta_description, :string, default: ""
    field :license_number, :string, default: ""
    field :years_of_experience, :integer, default: 0
    field :joined_at, Ecto.Date
    field :visible, :boolean, default: true

    belongs_to :user, CedaRealty.User
    belongs_to :office, CedaRealty.Office
    has_many :mls_names, CedaRealty.MlsName
    has_many :designations_profiles, CedaRealty.DesignationProfile
    has_many :designations, through: [:designations_profiles, :designation]

    timestamps
  end

  def changeset(model, action, params \\ :empty) do
    model
    |> cast(params, required_fields, optional_fields)
    |> set_picture_attributes(params)
    |> validate_length(:first_name, max: 128)
    |> validate_length(:last_name, max: 128)
    |> validate_length(:display_name, max: 256)
  end

  defp required_fields do
    ~w()
  end

  defp optional_fields do
    ~w(display_name first_name last_name display_email_address phone_number
       website_uri facebook_uri twitter_username linked_in_uri active_rain_uri
       youtube_uri instagram_uri bio_body bio_style bio_script meta_description
       license_number years_of_experience joined_at visible)
  end
end

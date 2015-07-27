defmodule CedaRealty.Repo.Migrations.CreateProfile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :user_id, :integer, null: false
      add :office_id, :integer
      add :picture_path, :string, null: false, default: ""
      add :picture_file_size, :integer, null: false, default: 0
      add :picture_file_content_type, :string, null: false, default: ""
      add :picture_original_file_name, :string, null: false, default: ""
      add :picture_checksum, :string, null: false, default: ""
      add :first_name, :string, null: false, default: ""
      add :last_name, :string, null: false, default: ""
      add :display_name, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :title, :string, null: false, default: ""
      add :display_email_address, :string, null: false, default: ""
      add :phone_number, :string, null: false, default: ""
      add :website_uri, :string, null: false, default: ""
      add :facebook_uri, :string, null: false, default: ""
      add :twitter_username, :string, null: false, default: ""
      add :linked_in_uri, :string, null: false, default: ""
      add :active_rain_uri, :string, null: false, default: ""
      add :youtube_uri, :string, null: false, default: ""
      add :instagram_uri, :string, null: false, default: ""
      add :bio_body, :text, null: false, default: ""
      add :bio_style, :text, null: false, default: ""
      add :bio_script, :text, null: false, default: ""
      add :meta_description, :text, null: false, default: ""
      add :license_number, :string, null: false, default: ""
      add :years_of_experience, :integer, null: false, default: 0
      add :joined_at, :date
      add :visible, :boolean, null: false, default: true

      timestamps
    end

    create index(:profiles, [:user_id])
    create index(:profiles, [:office_id])
    create index(:profiles, [:slug], unique: true)
    create index(:profiles, [:visible])
  end
end

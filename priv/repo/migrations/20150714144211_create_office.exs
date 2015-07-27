defmodule CedaRealty.Repo.Migrations.CreateOffice do
  use Ecto.Migration

  def change do
    create table(:offices) do
      add :manager_id, :integer
      add :picture_path, :string, null: false, default: ""
      add :picture_file_size, :integer, null: false, default: 0
      add :picture_file_content_type, :string, null: false, default: ""
      add :picture_original_file_name, :string, null: false, default: ""
      add :picture_checksum, :string, null: false, default: ""
      add :name, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :street_address_1, :string, null: false, default: ""
      add :street_address_2, :string, null: false, default: ""
      add :city, :string, null: false, default: ""
      add :state, :string, null: false, default: ""
      add :zipcode, :string, null: false, default: ""
      add :phone_number, :string, null: false, default: ""
      add :fax_number, :string, null: false, default: ""
      add :description_body, :text, null: false, default: ""
      add :description_style, :text, null: false, default: ""
      add :description_script, :text, null: false, default: ""
      add :meta_description, :text, null: false, default: ""
      add :google_maps_uri, :text, null: false, default: ""
      add :visible, :boolean, null: false, default: true

      timestamps
    end

    create index(:offices, [:manager_id])
    create index(:offices, [:slug], unique: true)
    create index(:offices, [:visible])
  end
end

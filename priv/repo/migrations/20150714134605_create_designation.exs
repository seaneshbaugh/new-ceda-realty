defmodule CedaRealty.Repo.Migrations.CreateDesignation do
  use Ecto.Migration

  def change do
    create table(:designations) do
      add :name, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :abbreviation, :string, null: false, default: ""
      add :description, :text, null: false, default: ""
      add :logo_path, :string, null: false, default: ""
      add :logo_file_size, :integer, null: false, default: 0
      add :logo_file_content_type, :string, null: false, default: ""
      add :logo_original_file_name, :string, null: false, default: ""
      add :logo_checksum, :string, null: false, default: ""
      add :visible, :boolean, null: false, default: true

      timestamps
    end

    create index(:designations, [:slug], unique: true)
    create index(:designations, [:visible])
  end
end

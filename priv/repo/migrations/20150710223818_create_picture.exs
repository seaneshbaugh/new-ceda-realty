defmodule CedaRealty.Repo.Migrations.CreatePicture do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add :file_path, :string, null: false, default: ""
      add :file_file_size, :integer,  null: false, default: 0
      add :file_file_content_type, :string, null: false, default: ""
      add :file_original_file_name, :string, null: false, default: ""
      add :file_checksum, :string, null: false, default: ""

      timestamps
    end

    create index(:pictures, [:file_checksum], unique: true)
  end
end

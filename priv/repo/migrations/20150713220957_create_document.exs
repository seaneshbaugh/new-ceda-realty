defmodule CedaRealty.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :directory_id, :integer
      add :user_id, :integer
      add :office_id, :integer
      add :name, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :full_path, :string, null: false, default: ""
      add :file_path, :string, null: false, default: ""
      add :file_size, :integer,  null: false, default: 0
      add :file_content_type, :string, null: false, default: ""
      add :file_original_file_name, :string, null: false, default: ""
      add :file_checksum, :string, null: false, default: ""

      timestamps
    end

    create index(:documents, [:directory_id])
    create index(:documents, [:user_id])
    create index(:documents, [:office_id])
    create index(:documents, [:slug])
    create index(:documents, [:full_path])
  end
end

defmodule CedaRealty.Repo.Migrations.CreateDirectory do
  use Ecto.Migration

  def change do
    create table(:directories) do
      add :parent_id, :integer
      add :user_id, :integer
      add :office_id, :integer
      add :name, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :full_path, :string, null: false, default: ""

      timestamps
    end

    create index(:directories, [:parent_id])
    create index(:directories, [:user_id])
    create index(:directories, [:office_id])
    create index(:directories, [:slug])
    create index(:directories, [:full_path])
  end
end

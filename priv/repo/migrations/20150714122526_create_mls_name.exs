defmodule CedaRealty.Repo.Migrations.CreateMlsName do
  use Ecto.Migration

  def change do
    create table(:mls_names) do
      add :profile_id, :integer, null: false
      add :name, :string, null: false, default: ""

      timestamps
    end

    create index(:mls_names, [:profile_id])
  end
end

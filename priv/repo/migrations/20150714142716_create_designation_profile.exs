defmodule CedaRealty.Repo.Migrations.CreateDesignationProfile do
  use Ecto.Migration

  def change do
    create table(:designations_profiles) do
      add :designation_id, :integer, null: false
      add :profile_id, :integer, null: false

      timestamps
    end

    create index(:designations_profiles, [:designation_id])
    create index(:designations_profiles, [:profile_id])
    create index(:designations_profiles, [:designation_id, :profile_id], unique: true)
  end
end

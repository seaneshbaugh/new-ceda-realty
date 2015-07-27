defmodule CedaRealty.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, :integer
      add :title, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :body, :text, null: false, default: ""
      add :style, :text, null: false, default: ""
      add :script, :text, null: false, default: ""
      add :meta_description, :text, null: false, default: ""
      add :published, :boolean,  null: false, default: true

      timestamps
    end

    create index(:posts, [:user_id])
    create index(:posts, [:slug], unique: true)
    create index(:posts, [:published])
  end
end

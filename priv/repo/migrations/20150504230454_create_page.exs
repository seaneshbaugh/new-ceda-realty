defmodule CedaRealty.Repo.Migrations.CreatePage do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :parent_id, :integer
      add :title, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""
      add :full_path, :string, null: false, default: ""
      add :body, :text, null: false, default: ""
      add :style, :text, null: false, default: ""
      add :script, :text, null: false, default: ""
      add :meta_description, :text, null: false, default: ""
      add :meta_keywords, :text, null: false, default: ""
      add :show_in_menu, :boolean, null: false, default: true
      add :published, :boolean,  null: false, default: true
      add :order, :integer, null: false, default: 0

      timestamps
    end

    create index(:pages, [:parent_id])
    create index(:pages, [:slug])
    create index(:pages, [:full_path], unique: true)
    create index(:pages, [:show_in_menu])
    create index(:pages, [:published])
  end
end

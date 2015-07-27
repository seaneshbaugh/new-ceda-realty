defmodule CedaRealty.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false, default: ""
      add :email, :string, null: false, default: ""
      add :encrypted_password, :string, null: false, default: ""
      add :role, :string, null: false, default: "read_only"
      add :reset_password_token
      add :reset_password_sent_at, :datetime
      add :remember_created_at, :datetime
      add :sign_in_count, :integer, null: false, default: 0
      add :current_sign_in_at, :datetime
      add :last_sign_in_at, :datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string

      timestamps
    end

    create index(:users, [:username], unique: true)
    create index(:users, [:email], unique: true)
    create index(:users, [:role])
    create index(:users, [:reset_password_token], unique: true)
  end
end

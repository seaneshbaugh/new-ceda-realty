defmodule CedaRealty.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :encrypted_password, :string
      add :role, :string
      add :reset_password_token, :string
      add :reset_password_sent_at, :datetime
      add :remember_created_at, :datetime
      add :sign_in_count, :integer
      add :current_sign_in_at, :datetime
      add :last_sign_in_at, :datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string

      timestamps
    end
  end
end

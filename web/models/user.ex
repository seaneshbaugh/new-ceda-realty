defmodule CedaRealty.User do
  use CedaRealty.Web, :model
  import Comeonin.Bcrypt

  schema "users" do
    field :username, :string, default: ""
    field :email, :string, default: ""
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :encrypted_password, :string, default: ""
    field :role, :string, default: "read_only"
    field :reset_password_token, :string
    field :reset_password_sent_at, Ecto.DateTime
    field :remember_created_at, Ecto.DateTime
    field :sign_in_count, :integer, default: 0
    field :current_sign_in_at, Ecto.DateTime
    field :last_sign_in_at, Ecto.DateTime
    field :current_sign_in_ip, :string
    field :last_sign_in_ip, :string

    has_one :profile, CedaRealty.Profile

    timestamps
  end

  def changeset(model, action, params \\ :empty)

  def changeset(model, :login, conn) do
    changeset = change(model)

    changeset
    |> Ecto.Changeset.put_change(:sign_in_count, Ecto.Changeset.get_field(changeset, :sign_in_count) + 1)
    |> Ecto.Changeset.put_change(:last_sign_in_at, Ecto.Changeset.get_field(changeset, :current_sign_in_at))
    |> Ecto.Changeset.put_change(:current_sign_in_at, Ecto.DateTime.local)
    |> Ecto.Changeset.put_change(:last_sign_in_ip, Ecto.Changeset.get_field(changeset, :current_sign_in_ip))
    |> Ecto.Changeset.put_change(:current_sign_in_ip, Enum.join(Tuple.to_list(conn.remote_ip), "."))
  end

  def changeset(model, action, params) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> validate_password_confirmation
    |> set_hashed_password
    |> validate_length(:username, min: 3)
    |> validate_length(:username, max: 64)
  end

  defp required_fields_for(:create) do
    ~w(username email password password_confirmation role)
  end

  defp required_fields_for(:update) do
    ~w(username email role)
  end

  defp optional_fields_for(:create) do
    ~w()
  end

  defp optional_fields_for(:update) do
    ~w(password password_confirmation)
  end

  defp validate_password_confirmation(changeset) do
    password = Ecto.Changeset.get_field(changeset, :password, "")

    password_confirmation = Ecto.Changeset.get_field(changeset, :password_confirmation, "")

    case password do
      ^password_confirmation -> changeset
      _ -> Ecto.Changeset.add_error(changeset, :password, "must match confirmation")
    end
  end

  defp set_hashed_password(changeset) do
    case Ecto.Changeset.get_field(changeset, :password) do
      nil -> changeset
      password -> Ecto.Changeset.put_change(changeset, :encrypted_password, hashpwsalt(password))
    end
  end
end

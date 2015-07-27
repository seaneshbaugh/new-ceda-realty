defmodule CedaRealty.Post do
  use CedaRealty.Web, :model

  schema "posts" do
    field :title, :string, default: ""
    field :slug, :string, default: ""
    field :body, :string, default: ""
    field :style, :string, default: ""
    field :script, :string, default: ""
    field :meta_description, :string, default: ""
    field :published, :boolean, default: true

    belongs_to :user, CedaRealty.User

    timestamps
  end

  def changeset(model, action, params \\ :empty) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_slug
    |> validate_length(:title, min: 3)
    |> validate_length(:title, max: 64)
  end

  defp required_fields_for(:create) do
    ~w(title body published user_id)
  end

  defp required_fields_for(:update) do
    ~w(title body published)
  end

  defp optional_fields_for(:create) do
    ~w(style script meta_description)
  end

  defp optional_fields_for(:update) do
    ~w(style script meta_description)
  end

  defp set_slug(changeset) do
    title = Ecto.Changeset.get_field(changeset, :title)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(title || ""))
  end
end

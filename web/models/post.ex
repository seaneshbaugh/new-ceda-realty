defmodule CedaRealty.Post do
  use CedaRealty.Web, :model
  import CedaRealty.Concerns.DefaultValues

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :body, :string
    field :style, :string
    field :script, :string
    field :meta_description, :string
    field :published, :boolean

    belongs_to :user, CedaRealty.User

    timestamps
  end

  def changeset(model, action, params \\ :empty)

  def changeset(model, :new, _params) do
    model
    |> cast(:empty, ~w(), ~w())
  end

  def changeset(model, action, params) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_default_values(default_attributes)
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

  defp default_attributes do
    [
      title: "",
      slug: "",
      body: "",
      style: "",
      script: "",
      meta_description: "",
      published: true,
      user_id: nil
    ]
  end

  defp set_slug(changeset) do
    title = Ecto.Changeset.get_field(changeset, :title)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(title || ""))
  end
end

defmodule CedaRealty.Page do
  use CedaRealty.Web, :model
  import CedaRealty.Concerns.DefaultValues

  schema "pages" do
    field :title, :string
    field :slug, :string
    field :full_path, :string
    field :body, :string
    field :style, :string
    field :script, :string
    field :meta_description, :string
    field :meta_keywords, :string
    field :show_in_menu, :boolean
    field :published, :boolean
    field :order, :integer

    belongs_to :parent, CedaRealty.Page
    has_many :children, CedaRealty.Page, on_delete: :delete_all

    timestamps
  end

  def changeset(model, action, params \\ :empty) do
    model
    |> cast(params, required_fields_for(action), optional_fields_for(action))
    |> set_default_values(default_attributes)
    |> set_slug
    |> set_full_path
    |> validate_length(:title, min: 3)
    |> validate_length(:title, max: 64)
  end

  defp required_fields_for(:create) do
    ~w(title body show_in_menu published order)
  end

  defp required_fields_for(:update) do
    ~w(title body show_in_menu published order)
  end

  defp optional_fields_for(:create) do
    ~w(style script meta_description parent_id)
  end

  defp optional_fields_for(:update) do
    ~w(style script meta_description parent_id)
  end

  defp default_attributes do
    [
      title: "",
      slug: "",
      full_path: "",
      body: "",
      style: "",
      script: "",
      meta_description: "",
      meta_keywords: "",
      show_in_menu: true,
      published: true,
      order: 0,
      parent_id: nil
    ]
  end

  defp set_slug(changeset) do
    title = Ecto.Changeset.get_field(changeset, :title)

    Ecto.Changeset.put_change(changeset, :slug, Inflex.parameterize(title || ""))
  end

  defp set_full_path(changeset) do
    slug = Ecto.Changeset.get_field(changeset, :slug)

    parent_id = Ecto.Changeset.get_field(changeset, :parent_id)

    if parent_id do
      parent = CedaRealty.Repo.one(from page in CedaRealty.Page, where: page.id == ^parent_id)

      if parent do
        Ecto.Changeset.put_change(changeset, :full_path, parent.full_path <> "/" <> slug)
      else
        Ecto.Changeset.add_error(changeset, :parent_id, "is not a valid page")
      end
    else
      Ecto.Changeset.put_change(changeset, :full_path, "/" <> slug)
    end
  end
end

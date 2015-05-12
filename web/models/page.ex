defmodule CedaRealty.Page do
  use CedaRealty.Web, :model

  schema "pages" do
    field :parent_id, :integer
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

    timestamps
  end

  def changeset(model, params \\ nil) do
    model
    |> cast(params, required_fields, optional_fields)
  end

  defp required_fields do
    ~w(title body style script meta_description meta_keywords show_in_menu published order)
  end

  defp optional_fields do
    ~w()
  end
end

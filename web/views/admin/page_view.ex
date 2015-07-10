defmodule CedaRealty.Admin.PageView do
  use CedaRealty.Web, :view

  def parent(%CedaRealty.Page{ parent: nil }, _conn), do: "N/A"
  def parent(%CedaRealty.Page{} = page, conn), do: link(page.parent.title, to: CedaRealty.Router.Helpers.admin_page_path(conn, :show, page.parent))

  def show_in_menu(%CedaRealty.Page{ show_in_menu: true }), do: "Yes"
  def show_in_menu(%CedaRealty.Page{ show_in_menu: false }), do: "No"

  def published(%CedaRealty.Page{ published: true }), do: "Yes"
  def published(%CedaRealty.Page{ published: false }), do: "No"

  def parent_page_options(changeset, pages) do
    id = Ecto.Changeset.get_field(changeset, :id)

    pages
    |> Enum.reject(fn page -> page.id == id end)
    |> Enum.reduce([], fn page, options -> Keyword.put(options, String.to_atom(page.title), Integer.to_string(page.id)) end)
  end
end

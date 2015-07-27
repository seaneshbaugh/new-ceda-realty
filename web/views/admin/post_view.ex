defmodule CedaRealty.Admin.PostView do
  use CedaRealty.Web, :view

  def published(%CedaRealty.Page{published: true}), do: "Yes"
  def published(%CedaRealty.Page{published: false}), do: "No"
end

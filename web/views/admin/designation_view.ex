defmodule CedaRealty.Admin.DesignationView do
  use CedaRealty.Web, :view

  def designation_logo_path(designation) do
    "/system/designations/logos/" <> designation.logo_path
  end

  def visible(%CedaRealty.Designation{visible: true}), do: "Yes"
  def visible(%CedaRealty.Designation{visible: false}), do: "No"
end

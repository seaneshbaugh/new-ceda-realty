defmodule CedaRealty.Admin.OfficeView do
  use CedaRealty.Web, :view

  def office_picture_path(office) do
    "/system/offices/pictures/" <> office.picture_path
  end
end

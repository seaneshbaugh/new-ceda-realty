defmodule CedaRealty.Admin.PictureView do
  use CedaRealty.Web, :view

  def picture_file_path(picture) do
    "/system/pictures/" <> picture.file_path
  end

  def picture_file_thumbnail_path(picture) do
    parts = String.split(picture_file_path(picture), ".")

    Enum.join(Enum.take(parts, length(parts) - 1), ".") <> "_thumbnail." <> List.first(Enum.take(parts, -1))
  end
end

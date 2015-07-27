defmodule CedaRealty.Admin.DocumentView do
  use CedaRealty.Web, :view

  def document_file_path(document) do
    "/system/documents/files/" <> document.file_path
  end
end

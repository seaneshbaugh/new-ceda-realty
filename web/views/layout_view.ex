defmodule CedaRealty.LayoutView do
  use CedaRealty.Web, :view
  import Ecto.Query

  def current_user_first_name(%CedaRealty.User{profile: %CedaRealty.Profile{first_name: first_name}}), do: first_name

  def current_user_first_name(%CedaRealty.User{profile: nil, username: username}), do: username
end

defmodule CedaRealty.Admin.ProfileView do
  use CedaRealty.Web, :view

  def full_name(profile) do
    cond do
      profile.display_name != "" ->
        profile.display_name
      profile.first_name != "" && profile.last_name != "" ->
        [profile.first_name, profile.last_name] |> Enum.join(" ")
      true ->
        (profile |> CedaRealty.Repo.preload(:user)).user.username
    end
  end
end

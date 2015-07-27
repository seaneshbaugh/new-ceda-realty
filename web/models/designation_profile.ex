defmodule CedaRealty.DesignationProfile do
  use CedaRealty.Web, :model

  schema "designations_profiles" do
    belongs_to :designation, CedaRealty.Designation
    belongs_to :profile, CedaRealty.Profile

    timestamps
  end
end

defmodule CedaRealty.MlsName do
  use CedaRealty.Web, :model

  schema "mls_names" do
    field :name, :string, default: ""

    belongs_to :profile, CedaRealty.Profile

    timestamps
  end
end

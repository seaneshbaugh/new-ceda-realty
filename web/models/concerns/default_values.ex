defmodule CedaRealty.Concerns.DefaultValues do
  def set_default_values(changeset, defaults) do
    Enum.reduce defaults, changeset, fn default, acc ->
      {attribute, value} = default

      if Ecto.Changeset.get_field(acc, attribute) == nil do
        Ecto.Changeset.put_change(acc, attribute, value)
      else
        acc
      end
    end
  end
end

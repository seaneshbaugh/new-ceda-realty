use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :ceda_realty, CedaRealty.Endpoint,
  secret_key_base: "hhrZv89eudNv+qvr2PQ3MvjueQJdD/3r17kt8GoqgtE+FChkJhm/FLX07mHbjQwG"

# Configure your database
config :ceda_realty, CedaRealty.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ceda_realty_prod"

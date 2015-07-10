# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :ceda_realty, CedaRealty.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "YhsC4/1tATgxx23fcni1vr026uJQ0ZlLbmykbHQA5wq4YbgPdXxScus3fyhTGXtw",
  render_errors: [default_format: "html"],
  pubsub: [name: CedaRealty.PubSub,
           adapter: Phoenix.PubSub.PG2],
  remember_me: [key: "_remember_me_token",
                encryption_salt: "VzQ0Tr91lVVJ2yPF",
                signing_salt: "deW9u3bUcbyz6fik"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

config :canary, repo: CedaRealty.Repo

config :exseed, :repo, CedaRealty.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

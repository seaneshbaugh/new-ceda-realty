defmodule CedaRealty.Mixfile do
  use Mix.Project

  def project do
    [app: :ceda_realty,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {CedaRealty, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.14"},
     {:phoenix_ecto, "~> 0.5"},
     {:postgrex, "~> 0.8.3"},
     {:phoenix_haml, "~> 0.1.2"},
     {:phoenix_html, "~> 1.1"},
     {:phoenix_live_reload, "~> 0.4", only: :dev},
     {:cowboy, "~> 1.0"},
     {:canary, "~> 0.8.0"},
     {:comeonin, "~> 1.0"},
     {:exseed, "~> 0.0.2"},
     {:mogrify, "~> 0.1"},
     {:inflex, "~> 1.3.0"}]
  end
end

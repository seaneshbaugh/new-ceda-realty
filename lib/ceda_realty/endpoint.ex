defmodule CedaRealty.Endpoint do
  use Phoenix.Endpoint, otp_app: :ceda_realty

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :ceda_realty, gzip: false,
    only: ~w(css images js system favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_ceda_realty_key",
    signing_salt: "Jf/bnSGK",
    encryption_salt: "RE8DI/hV"

  plug CedaRealty.Plugs.RememberMePlug,
    key: config[:remember_me][:key],
    encryption_salt: config[:remember_me][:encryption_salt],
    signing_salt: config[:remember_me][:signing_salt]

  plug CedaRealty.Plugs.SetCurrentUser

  plug :router, CedaRealty.Router
end

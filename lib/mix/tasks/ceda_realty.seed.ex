defmodule Mix.Tasks.Cedarealty.Seed do
  use Mix.Task
  use CedaRealty.Web, :controller
  import Supervisor.Spec, warn: false

  @shortdoc "Seed the database."

  @moduledoc "Seed the database."

  def run(_args) do
    children = [
      worker(CedaRealty.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: CedaRealty.Supervisor]

    Supervisor.start_link(children, opts)

    if CedaRealty.Repo.one(from user in CedaRealty.User, select: count(user.id)) == 0 do
      changeset = CedaRealty.User.changeset(%CedaRealty.User{}, :create, %{username: "admin", email: "admin@cedarealty.com", password: "changeme", password_confirmation: "changeme", role: "sysadmin"})

      if changeset.valid? do
        Repo.insert(changeset)
      else
        Mix.shell.info changeset.errors
      end
    end
  end
end

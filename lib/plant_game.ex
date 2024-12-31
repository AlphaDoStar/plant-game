defmodule PlantGame do
  use Application

  @moduledoc """
  The main application module for the PlantGame.
  """

  def start(_type, _args) do
    children = [
      { Registry, keys: :unique, name: PlantGame.Registry },
      PlantGame.PlantSupervisor
    ]

    opts = [strategy: :one_for_one, name: PlantGame.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule PlantGame.PlantSupervisor do
  use DynamicSupervisor

  alias PlantGame.Server

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_plant(name) do
    DynamicSupervisor.start_child(__MODULE__, { Server, name })
  end
end

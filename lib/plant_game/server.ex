defmodule PlantGame.Server do
  use GenServer

  alias PlantGame.Plant

  @update_interval 10_000

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end

  def water(name, amount) do
    GenServer.call(via_tuple(name), { :water, amount })
  end

  def grow(name) do
    GenServer.call(via_tuple(name), :grow)
  end

  def get_state(name) do
    GenServer.call(via_tuple(name), :get_state)
  end

  def init(name) do
    schedule_update()
    { :ok, Plant.new(name) }
  end

  def handle_info(:update, plant) do
    updated_plant = %{ plant | moisture: max(plant.moisture - 10, 0) }

    if updated_plant.moisture < 20 do
      IO.puts("[Warning] #{updated_plant.name} is running low on moisture!")
    end

    schedule_update()
    { :noreply, updated_plant }
  end

  def handle_call({ :water, amount }, _from, plant) do
    updated_plant = Plant.water(plant, amount)
    { :reply, updated_plant, updated_plant }
  end

  def handle_call(:grow, _from, plant) do
    updated_plant = Plant.grow(plant)
    { :reply, updated_plant, updated_plant }
  end

  def handle_call(:get_state, _from, plant) do
    { :reply, plant, plant }
  end

  defp via_tuple(name), do: { :via, Registry, { PlantGame.Registry, name } }

  defp schedule_update do
    Process.send_after(self(), :update, @update_interval)
  end
end

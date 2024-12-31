defmodule PlantGame.Plant do
  @moduledoc """
  A module for managing the state of a plant.
  """

  defstruct name: "", moisture: 50, health: 100, growth_stage: 1

  def new(name) when is_binary(name) do
    %__MODULE__{ name: name }
  end

  def water(plant, amount) when is_integer(amount) do
    %{ plant | moisture: min(plant.moisture + amount, 100) }
  end

  def grow(%__MODULE__{ moisture: moisture, health: health } = plant) do
    if moisture > 30 and health > 50 do
      %{ plant | growth_stage: plant.growth_stage + 1, moisture: moisture - 20 }
    else
      plant
    end
  end
end

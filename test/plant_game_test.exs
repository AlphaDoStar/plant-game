defmodule PlantGameTest do
  use ExUnit.Case
  doctest PlantGame

  test "greets the world" do
    assert PlantGame.hello() == :world
  end
end

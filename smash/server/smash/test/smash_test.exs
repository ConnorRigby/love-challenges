defmodule SmashTest do
  use ExUnit.Case
  doctest Smash

  test "greets the world" do
    assert Smash.hello() == :world
  end
end

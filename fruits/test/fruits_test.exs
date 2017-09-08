defmodule FruitsTest do
  use ExUnit.Case
  doctest Fruits

  test "greets the world" do
    assert Fruits.hello() == :world
  end
end

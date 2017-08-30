defmodule MySigilsTest do
  use ExUnit.Case
  import MySigils

  test "custom u sigil" do
    assert ~u[foo bar] == ["FOO", "BAR"]
  end
end

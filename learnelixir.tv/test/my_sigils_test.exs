defmodule MySigilsTest do
  use ExUnit.Case
  import Kernel, except: [sigil_w: 2]
  import MySigils

  test "custom u sigil" do
    assert ~u[foo bar] == ["FOO", "BAR"]
  end

  test "overriden w sigil does ignore modifiers" do
    assert ~w[foo bar]a == ["foo", "bar"]
  end
end

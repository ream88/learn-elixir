defmodule SchizoTest do
  use ExUnit.Case
  doctest Schizo

  test "uppercase doesn't change the first word" do
    assert Schizo.uppercase("foo") == "foo"
  end

  test "uppercase convers the second word to uppercase" do
    assert Schizo.uppercase("foo bar") == "foo BAR"
  end

  test "uppercase converts every other word to uppercase" do
    assert Schizo.uppercase("foo bar baz qux") == "foo BAR baz QUX"
  end

  test "unvowel doesn't change the first word" do
    assert Schizo.unvowel("foo") == "foo"
  end

  test "unvowel convers the second word to unvowel" do
    assert Schizo.unvowel("foo bar") == "foo br"
  end

  test "unvowel converts every other word to unvowel" do
    assert Schizo.unvowel("foo bar baz qux") == "foo br baz qx"
  end
end

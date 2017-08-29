defmodule MyListTest do
  use ExUnit.Case
  doctest MyList

  describe "length" do
    test "is given an empty list" do
      assert MyList.length([]) == 0
    end

    test "is given a list with 3 items" do
      assert MyList.length([1, 2, 3]) == 3
    end
  end

  describe "each" do
    test "is given an empty list" do
      assert MyList.each([], &IO.puts/1) == :ok
    end

    test "is given a list with 3 items" do
      assert MyList.each([1, 2, 3], &IO.puts/1) == :ok
    end
  end

  describe "map" do
    test "is given an empty list" do
      fun = fn(i) -> i * 2 end
      assert MyList.map([], fun) == []
    end

    test "is given a list with 3 items" do
      fun = fn(i) -> i * 2 end
      assert MyList.map([1, 2, 3], fun) == [2, 4, 6]
    end
  end

  describe "sum" do
    test "is given an empty list" do
      assert MyList.sum([]) == 0
    end

    test "is given a list with 3 items" do
      assert MyList.sum([1, 2, 3]) == 6
    end
  end
end

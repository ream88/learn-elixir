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
end

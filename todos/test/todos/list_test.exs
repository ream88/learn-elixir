defmodule Todos.ListTest do
  use ExUnit.Case
  alias Todos.{Item,List}

  setup do
    {:ok, list} = List.start_link("Shopping")
    {:ok, list: list}
  end

  test ".items returns the items in the given list", %{list: list} do
    assert List.items(list) == []
  end

  test ".add adds the given item to the list", %{list: list} do
    item = Item.new("Buy milk")

    List.add(list, item)
    assert List.items(list) == [item]
  end

  test ".update updates the given item", %{list: list} do
    item = Item.new("Buy milk")
    List.add(list, item)

    item = %{item | completed: true}
    List.update(list, item)

    assert List.items(list) == [item]
  end

  test ".name returns the name of the list", %{list: list} do
    assert List.name(list) == "Shopping"
  end
end

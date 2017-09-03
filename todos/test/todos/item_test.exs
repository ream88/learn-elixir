defmodule Todos.ItemTest do
  use ExUnit.Case
  alias Todos.Item

  test ".new creates a new incompleted todo item" do
    assert Item.new("buy milk").completed == false
  end
end

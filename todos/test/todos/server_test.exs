defmodule Todos.ServerTest do
  use ExUnit.Case
  alias Todos.Server

  setup do
    on_exit fn ->
      Enum.each(Server.lists, &Server.delete_list(&1))
    end
  end

  test ".add_list adds a new supervised list" do
    Server.add_list("Shopping")
    Server.add_list("Work")

    assert Supervisor.count_children(Server).active == 2
  end

  test ".find_list finds a list by the given name" do
    Server.add_list("Shopping")

    list = Server.find_list("Shopping")
    assert is_pid(list)
  end

  test ".delete_list deletes the given list" do
    Server.add_list("Shopping")
    list = Server.find_list("Shopping")

    Server.delete_list(list)
    assert Supervisor.count_children(Server).active == 0
  end

  test ".lists returns all active lists" do
    Server.add_list("Shopping")

    assert Enum.count(Server.lists) == 1
  end
end

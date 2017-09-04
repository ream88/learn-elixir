defmodule Todos.Server do
  use Supervisor

  def lists do
    __MODULE__
    |> Supervisor.which_children
    |> Enum.map(fn({_, child, _, _}) -> child end)
  end

  def find_list(name) do
    Enum.find(lists(), fn(child) ->
      Todos.List.name(child) == name
    end)
  end

  def add_list(name) do
    Supervisor.start_child(__MODULE__, [name])
  end

  def delete_list(list) do
    Supervisor.terminate_child(__MODULE__, list)
  end

  ###
  # Supervisior API
  ###

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(Todos.List, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end

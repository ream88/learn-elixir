defmodule Parallel do
  def pmap(list, fun) do
    list
    |> Enum.map(&spawn_process(&1, self(), fun))
    |> Enum.map(&await/1)
  end

  def smap(list, fun) do
    list
    |> Stream.map(&spawn_process(&1, self(), fun))
    |> Stream.map(&await/1)
  end

  defp spawn_process(item, parent, fun) do
    spawn_link fn ->
      send parent, {self(), fun.(item)}
    end
  end

  defp await(pid) do
    receive do
      {^pid, result} -> result
    end
  end
end

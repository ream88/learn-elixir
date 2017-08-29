defmodule MyList do
  def length(list) do
    length(list, 0)
  end

  defp length([], count) do
    count
  end

  defp length([_ | list], count) do
    length(list, count + 1)
  end

  def each([], _fun) do
    :ok
  end

  def each([item | list], fun) do
    fun.(item)
    each(list, fun)
  end

  def map(list, fun) do
    map(list, fun, [])
  end

  defp map([item | list], fun, acc) do
    acc = acc ++ [fun.(item)]
    map(list, fun, acc)
  end

  defp map([], _fun, acc) do
    acc
  end
end

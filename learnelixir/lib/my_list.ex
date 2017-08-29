defmodule MyList do
  def length(list) do
    do_length(list, 0)
  end

  defp do_length([], count) do
    count
  end

  defp do_length([_ | list], count) do
    do_length(list, count + 1)
  end

  def each([], _fun) do
    :ok
  end

  def each([item | list], fun) do
    fun.(item)
    each(list, fun)
  end

  def map(list, fun) do
    do_map(list, fun, [])
  end

  defp do_map([item | list], fun, acc) do
    acc = [fun.(item) | acc]
    do_map(list, fun, acc)
  end

  defp do_map([], _fun, acc) do
    :lists.reverse(acc)
  end

  def sum(list) do
    do_sum(list, 0)
  end

  defp do_sum([], acc) do
    acc
  end

  defp do_sum([item | list], acc) do
    acc = acc + item
    do_sum(list, acc)
  end
end

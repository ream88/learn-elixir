list = Enum.to_list(1..10_000)
fun = &(&1 * 2)

Benchee.run(%{
  "parallel, enum"     => fn -> Parallel.pmap(list, fun) end,
  "not parallel, enum" => fn -> Enum.map(list, fun) end,
  "parallel, stream"     => fn -> Parallel.smap(list, fun) end,
  "not parallel, stream" => fn -> Stream.map(list, fun) end
}, time: 10)

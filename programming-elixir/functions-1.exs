list_concat = fn(a, b) -> a ++ b end
[:a, :b, :c, :d] = list_concat.([:a, :b], [:c, :d])

sum = fn(a, b, c) -> a + b + c end
6 = sum.(1, 2, 3)

pair_tuple_to_list = fn({a, b}) -> [a, b] end
[1234, 5678] = pair_tuple_to_list.({ 1234, 5678})

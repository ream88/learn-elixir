fizz_word = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

fb = fn n -> fizz_word.(rem(n, 3), rem(n, 5), n) end

"Buzz" = fb.(10)
11 = fb.(11)
"Fizz" = fb.(12)
13 = fb.(13)
14 = fb.(14)
"FizzBuzz" = fb.(15)
16 = fb.(16)

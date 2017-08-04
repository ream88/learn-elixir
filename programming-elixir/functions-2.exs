fizz_word = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

"FizzBuzz" = fizz_word.(0, 0, 0)
"Fizz" = fizz_word.(0, 1, 2)
"Buzz" = fizz_word.(-1, 0, 1)
3 = fizz_word.(1, 2, 3)

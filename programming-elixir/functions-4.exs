prefix = fn a -> fn b -> "#{a} #{b}" end end

"Mr. Smith" = prefix.("Mr.").("Smith")
mr = prefix.("Mr.")
"Mr. Smith" = mr.("Smith")

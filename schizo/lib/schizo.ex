defmodule Schizo do
  def uppercase(string) do
    for_every_other_word(string, &uppercaser/1)
  end

  def unvowel(string) do
    for_every_other_word(string, &unvoweler/1)
  end

  defp uppercaser(word) do
    String.upcase(word)
  end

  defp unvoweler(word) do
    Regex.replace(~r/[aeiou]/, word, "")
  end

  defp for_every_other_word(string, transformer) do
    string
    |> String.split(" ")
    |> Stream.with_index
    |> Enum.map(transform_every_other_word(transformer))
    |> Enum.join(" ")
  end

  defp transform_every_other_word(transformer) do
    fn({ word, index}) ->
      cond do
        rem(index, 2) == 0 -> word
        rem(index, 2) == 1 -> transformer.(word)
      end
    end
  end
end

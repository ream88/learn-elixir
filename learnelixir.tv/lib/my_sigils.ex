defmodule MySigils do
  def sigil_u(content, _) do
    content
    |> String.split
    |> Enum.map(&String.upcase/1)
  end
end

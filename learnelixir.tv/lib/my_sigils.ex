defmodule MySigils do
  import Kernel, except: [sigil_w: 2]

  def sigil_u(content, _) do
    content
    |> String.split
    |> Enum.map(&String.upcase/1)
  end

  def sigil_w(content, _) do
    content
    |> String.split
  end
end

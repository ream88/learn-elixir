defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> Enum.at(0)
      |> String.split(" ")

    %Conv{ method: method, path: path }
  end
end

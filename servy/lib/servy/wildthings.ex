defmodule Servy.Wildthings do
  alias Servy.Bear

  @db_path Path.expand("db", File.cwd!)

  def list_bears do
    @db_path
    |> Path.join("bears.json")
    |> File.read!
    |> Poison.decode!(keys: :atoms)
    |> Map.get(:bears)
    |> Enum.map(fn(attributes) -> struct(Bear, attributes) end)
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn(bear) -> bear.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    id |> String.to_integer |> get_bear
  end
end

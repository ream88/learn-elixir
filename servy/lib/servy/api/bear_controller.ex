defmodule Servy.Api.BearController do
  alias Servy.Bear
  alias Servy.Conv
  alias Servy.Wildthings
  import Servy.Handler, only: [put_content_type: 2]

  def index(%Conv{} = conv, _) do
    body =
      Wildthings.list_bears
      |> Enum.sort(&Bear.order_by_name_asc/2)
      |> Enum.map(&Map.from_struct/1)
      |> Enum.map(&normalize_keys/1)
      |> Poison.encode!

    conv = put_content_type(conv, "application/json")
    %{conv | body: body }
  end

  def create(%Conv{} = conv, params) do
    %{conv | body: "A #{params["type"]} bear named #{params["name"]} was created", status: 201}
  end

  @doc """
    Normalizes all keys for JSON in the given map.

    iex> Servy.Api.BearController.normalize_keys(%{hibernating: true})
    %{hibernating: true}
  """
  def normalize_keys(map) do
    for {key, val} <- map, into: %{}, do: {normalize_key(key), val}
  end

  defp normalize_key(key) do
    key
    |> Atom.to_string
    |> String.replace(~r/\?/, "")
    |> String.to_atom
  end
end

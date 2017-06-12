defmodule Servy.BearController do
  alias Servy.Bear
  alias Servy.Conv
  alias Servy.Wildthings

  defp bear_name(bear) do
    bear.name
  end

  def index(%Conv{} = conv, _) do
    body =
      Wildthings.list_bears
      |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_by_name_asc/2)
      |> Enum.map(&bear_name/1)
      |> Enum.join(", ")

    %{ conv | body: body }
  end

  def show(%Conv{} = conv, %{ "id" => id }) do
    bear = Wildthings.get_bear(id)

    cond do
      bear == nil -> %{ conv | body: "No bear with id #{id} found", status: 404 }
      bear != nil -> %{ conv | body: bear_name(bear) }
    end
  end
end

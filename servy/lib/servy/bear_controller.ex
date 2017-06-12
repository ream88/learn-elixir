defmodule Servy.BearController do
  alias Servy.Conv
  alias Servy.Wildthings

  def index(%Conv{} = conv, _) do
    name = fn(bear) -> bear.name end
    body =
      Wildthings.list_bears
      |> Enum.filter(fn(bear) -> bear.type == "Grizzly" end)
      |> Enum.sort(fn(bear1, bear2) -> bear1.name <= bear2.name end)
      |> Enum.map(&name.(&1))
      |> Enum.join(", ")

    %{ conv | body: body }
  end

  def show(%Conv{} = conv, %{ "id" => id }) do
    name = fn(bear) -> bear.name end
    bear = Wildthings.get_bear(id)

    cond do
      bear == nil -> %{ conv | body: "No bear with id #{id} found", status: 404 }
      bear != nil -> %{ conv | body: name.(bear) }
    end
  end
end

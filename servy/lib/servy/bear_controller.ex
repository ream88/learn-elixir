defmodule Servy.BearController do
  alias Servy.Bear
  alias Servy.Conv
  alias Servy.Wildthings

  def index(%Conv{} = conv, _) do
    body =
      Wildthings.list_bears
      |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_by_name_asc/2)
      |> Enum.map(fn(bear) -> "<li>#{bear.name}</li>" end)

    %{conv | body: "<h1>All the bears!</h1> <ul>#{body}</ul>"}
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    if bear != nil do
      %{conv | body: "<h1>Show bear</h1> Is #{bear.name} hibernating? <strong>#{bear.hibernating?}</strong>"}
    else
      %{conv | body: "No bear with id #{id} found", status: 404}
    end
  end

  def delete(%Conv{} = conv, _) do
    %{conv | body: "Deleting a bear is forbidden!", status: 403}
  end
end

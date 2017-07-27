defmodule Servy.BearController do
  alias Servy.Bear
  alias Servy.BearView
  alias Servy.Conv
  alias Servy.Wildthings

  def index(%Conv{} = conv, _) do
    bears =
      Wildthings.list_bears
      |> Enum.sort(&Bear.order_by_name_asc/2)

    %{conv | body: BearView.index(bears)}
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    case Wildthings.get_bear(id) do
      nil -> %{conv | body: "No bear with id #{id} found", status: 404}
      bear -> %{conv | body: BearView.show(bear)}
    end
  end

  def delete(%Conv{} = conv, _) do
    %{conv | body: "Deleting a bear is forbidden!", status: 403}
  end
end

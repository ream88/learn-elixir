defmodule Servy.Api.BearController do
  alias Servy.Bear
  alias Servy.Conv
  alias Servy.Wildthings

  def index(%Conv{} = conv, _) do
    bears =
      Wildthings.list_bears
      |> Enum.sort(&Bear.order_by_name_asc/2)

    %{conv | body: Poison.encode!(bears), content_type: "application/json" }
  end
end

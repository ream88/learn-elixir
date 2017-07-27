defmodule Servy.Routes do
  @pages_path Path.expand("pages", File.cwd!)

  alias Servy.Api
  alias Servy.BearController
  alias Servy.Conv

  import Servy.FileHandler, only: [handle_file: 2]

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/international-wildthings"} = conv) do
    %{conv | body: "Beärs, Liöns, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/pages/" <> page} = conv) do
    @pages_path
    |> Path.join(page)
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    BearController.index(conv, conv.params)
  end

  def route(%Conv{method: "GET", path: "/api/bears"} = conv) do
    Api.BearController.index(conv, conv.params)
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  def route(%Conv{method: "POST", path: "/bears", params: params} = conv) do
    %{conv | body: "A #{params["type"]} bear named #{params["name"]} was created"}
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
    BearController.delete(conv, conv.params)
  end

  def route(%Conv{path: path} = conv) do
    %{conv | body: "No #{path} found", status: 404}
  end
end

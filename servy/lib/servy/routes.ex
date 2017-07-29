defmodule Servy.Routes do
  @pages_path Path.expand("pages", File.cwd!)

  alias Servy.Api
  alias Servy.BearController
  alias Servy.Conv

  import Servy.FileHandler

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/international-wildthings"} = conv) do
    %{conv | body: "Beärs, Liöns, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/pages/" <> page} = conv) do
    page =
      case Path.extname(page) do
        ".html" -> page
        "" -> "#{page}.md"
      end

    @pages_path
    |> Path.join(page)
    |> File.read
    |> handle_file(conv)
    |> handle_format
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
    %{conv | body: "A #{params["type"]} bear named #{params["name"]} was created", status: 201}
  end

  def route(%Conv{method: "POST", path: "/api/bears"} = conv) do
    Api.BearController.create(conv, conv.params)
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
    BearController.delete(conv, conv.params)
  end

  def route(%Conv{path: path} = conv) do
    %{conv | body: "No #{path} found", status: 404}
  end
end

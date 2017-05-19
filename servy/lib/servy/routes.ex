defmodule Servy.Routes do
  @pages_path Path.expand("pages", File.cwd!)

  import Servy.FileHandler, only: [handle_file: 2]

  def route(%{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | body: "Bears, Lions, Tigers" }
  end

  def route(%{ method: "GET", path: "/international-wildthings" } = conv) do
    %{ conv | body: "Beärs, Liöns, Tigers" }
  end

  def route(%{ method: "GET", path: "/pages/" <> page } = conv) do
    @pages_path
    |> Path.join(page)
    |> File.read
    |> handle_file(conv)
  end

  def route(%{ method: "GET", path: "/bears" } = conv) do
    %{ conv | body: Enum.join(Wildthings.bears, ", ") }
  end

  def route(%{ method: "GET", path: "/bears/" <> id } = conv) do
    body = Enum.at(Wildthings.bears, String.to_integer(id) - 1)
    cond do
      body == nil -> %{ conv | body: "No bear with id #{id} found", status: 404 }
      body != nil -> %{ conv | body: body }
    end
  end

  def route(%{ method: "DELETE", path: "/bears/" <> _id } = conv) do
    %{ conv | body: "Deleting a bear is forbidden!", status: 403 }
  end

  def route(%{ path: path } = conv) do
    %{ conv | body: "No #{path} found", status: 404 }
  end
end

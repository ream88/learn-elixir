defmodule Servy.FileHandler do
  alias Servy.Conv

  def handle_file({:ok, content}, %Conv{} = conv) do
    %{conv | body: content}
  end

  def handle_file({:error, :enoent}, %Conv{path: "/pages/" <> page} = conv) do
    %{conv | status: 404, body: "Page #{page} not found"}
  end

  def handle_format(%Conv{path: "/pages/" <> page} = conv) do
    content =
      case Path.extname(page) do
        ".html" -> conv.body
        "" -> Earmark.as_html!(conv.body)
      end

    %{conv | body: content}
  end
end

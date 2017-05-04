defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> route
    |> format_response
  end

  defp parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> Enum.at(0)
      |> String.split(" ")

    %{ method: method, path: path, resp_body: "" }
  end

  defp route(conv) do
    route(conv, conv.path)
  end

  defp route(conv, "/wildthings") do
    %{ conv | resp_body: "Bears, Lions, Tigers" }
  end

  defp route(conv, "/international-wildthings") do
    %{ conv | resp_body: "Beärs, Liöns, Tigers" }
  end

  defp format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

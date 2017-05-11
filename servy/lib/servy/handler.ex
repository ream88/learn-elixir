defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  defp log(conv), do: IO.inspect conv

  defp parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> Enum.at(0)
      |> String.split(" ")

    %{ method: method, path: path, body: "", status: 200 }
  end

  defp route(conv) do
    route(conv, conv.path)
  end

  defp route(conv, "/wildthings") do
    %{ conv | body: "Bears, Lions, Tigers" }
  end

  defp route(conv, "/international-wildthings") do
    %{ conv | body: "Beärs, Liöns, Tigers" }
  end

  defp route(conv, "/bears") do
    %{ conv | body: "Teddy, Smokey, Paddington" }
  end

  defp route(conv, path) do
    %{ conv | body: "No #{path} found", status: 404 }
  end

  defp format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.body)}

    #{conv.body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end

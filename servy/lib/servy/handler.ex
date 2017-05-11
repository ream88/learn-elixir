defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
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

  defp rewrite_path(%{ method: "GET", path: "/wildlife" } = conv) do
    %{ conv | path: "/wildthings" }
  end

  defp rewrite_path(%{ method: "GET", path: "/bears?id=" <> id } = conv) do
    %{ conv | path: "/bears/#{id}" }
  end

  defp rewrite_path(conv), do: conv

  defp route(%{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | body: "Bears, Lions, Tigers" }
  end

  defp route(%{ method: "GET", path: "/international-wildthings" } = conv) do
    %{ conv | body: "Beärs, Liöns, Tigers" }
  end

  defp route(%{ method: "GET", path: "/bears" } = conv) do
    %{ conv | body: Enum.join(Wildthings.bears, ", ") }
  end

  defp route(%{ method: "GET", path: "/bears/" <> id } = conv) do
    body = Enum.at(Wildthings.bears, String.to_integer(id) - 1)
    cond do
      body == nil -> %{ conv | body: "No bear with id #{id} found", status: 404 }
      body != nil -> %{ conv | body: body }
    end
  end

  defp route(%{ method: "DELETE", path: "/bears/" <> _id } = conv) do
    %{ conv | body: "Deleting a bear is forbidden!", status: 403 }
  end

  defp route(%{ path: path } = conv) do
    %{ conv | body: "No #{path} found", status: 404 }
  end

  defp track(%{ status: 404, path: path } = conv) do
    IO.puts "Path #{path} not found!"
    conv
  end

  defp track(conv), do: conv

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

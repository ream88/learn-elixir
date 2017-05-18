require Logger

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

  defp log(conv) do
    Logger.info inspect(conv)
    conv
  end

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

  defp rewrite_path(%{ path: path } = conv) do
    regex = ~r{\/(?<resource>\w+)\?id=(?<id>\d)}
    captures = Regex.named_captures(regex, path)
    rewrite_named_captures(conv, captures)
  end

  defp rewrite_named_captures(conv, %{ "resource" => resource, "id" => id }) do
    Logger.warn "Rewriting #{conv.path} to /#{resource}/#{id}"
    %{ conv | path: "/#{resource}/#{id}" }
  end

  defp rewrite_named_captures(conv, _captures), do: conv

  defp route(%{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | body: "Bears, Lions, Tigers" }
  end

  defp route(%{ method: "GET", path: "/international-wildthings" } = conv) do
    %{ conv | body: "Beärs, Liöns, Tigers" }
  end

  defp route(%{ method: "GET", path: "/pages/" <> page } = conv) do
    file =
      Path.expand("../../pages", __DIR__)
      |> Path.join(page)
      |> File.read

    case file do
      {:ok, content} -> %{ conv | body: content }
      {:error, :enoent} -> %{ conv | status: 404, body: "Page #{page} not found" }
      {:error, reason} -> %{ conv | status: 500, body: "Internal Server Error (Reason: #{reason})" }
    end
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
    Logger.error "Path #{path} not found!"
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

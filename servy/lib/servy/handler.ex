defmodule Servy.Handler do
  alias Servy.Conv
  import Servy.Parser, only: [parse: 1]
  import Servy.Plugins, only: [log: 1, track: 1, rewrite_path: 1]
  import Servy.Routes, only: [route: 1]

  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> put_content_length
    |> format_response
  end

  defp format_response(%Conv{} = conv) do
    response_headers =
      for {key, val} <- conv.response_headers do
        "#{key}: #{val}"
      end |> Enum.sort |> Enum.reverse |> Enum.join("\r\n")

    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    #{response_headers}
    \r
    #{conv.body}
    """
  end

  def put_content_type(%Conv{} = conv, content_type) do
    headers = Map.put(conv.response_headers, "Content-Type", content_type)
    %{conv | response_headers: headers}
  end

  def put_content_length(%Conv{} = conv) do
    headers = Map.put(conv.response_headers, "Content-Length", Conv.content_length(conv))
    %{conv | response_headers: headers}
  end
end

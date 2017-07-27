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
    |> format_response
  end

  defp format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: #{conv.content_type}
    Content-Length: #{Conv.content_length(conv)}

    #{conv.body}
    """
  end
end

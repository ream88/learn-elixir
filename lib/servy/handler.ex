defmodule Servy.Handler do
  def handle(request) do
    conv = parse(request)
    conv = route(conv)
    format_response(conv)
  end

  def parse(request) do
    %{ method: "GET", path: "/wildthings", resp_body: "" }
  end

  def route(conv) do
    %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions and Tigers" }
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """
  end
end

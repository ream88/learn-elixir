defmodule Servy.Handler do
  def handle(request) do
    conv = parse(request)
    conv = route(conv)
    format_response(conv)
  end

  def parse(request) do
    lines = String.split(request, "\n")
    first_line = Enum.at(lines, 0)
    [method, path, _] = String.split(first_line, " ")

    %{ method: method, path: path, resp_body: "" }
  end

  def route(conv) do
    %{ conv | resp_body: "Bears, Lions, Tigers" }
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

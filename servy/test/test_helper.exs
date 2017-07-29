ExUnit.start()

defmodule TestHelper do
  def get(path) do
    Servy.Handler.handle("""
    GET #{path} HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """)
  end

  def post(path, body, content_type \\ "application/x-www-form-urlencoded") do
    Servy.Handler.handle("""
    POST #{path} HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: #{content_type}\r
    Content-Length: #{byte_size(body)}\r
    \r
    #{body}
    """)
  end

  def delete(path) do
    Servy.Handler.handle("""
    DELETE #{path} HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """)
  end
end

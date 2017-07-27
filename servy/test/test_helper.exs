ExUnit.start()

defmodule TestHelper do
  def get(path) do
    Servy.Handler.handle("""
    GET #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """)
  end

  def post(path, body) do
    Servy.Handler.handle("""
    POST #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: #{byte_size(body)}

    #{body}
    """)
  end

  def delete(path) do
    Servy.Handler.handle("""
    DELETE #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """)
  end
end

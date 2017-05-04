defmodule ServyTest do
  use ExUnit.Case, async: true

  test "/wildthings" do
    response = Servy.Handler.handle("""
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """)

    assert response =~ "Bears, Lions, Tigers"
    assert response =~ "Content-Length: 20"
  end

  test "/international-wildthings" do
    response = Servy.Handler.handle("""
    GET /international-wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """)

    assert response =~ "Beärs, Liöns, Tigers"
    assert response =~ "Content-Length: 22"
  end
end

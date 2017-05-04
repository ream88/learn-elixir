defmodule ServyTest do
  use ExUnit.Case, async: true

  test "/wildthings" do
    request = """
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    assert Servy.Handler.handle(request) =~ "Bears, Lions, Tigers"
  end
end

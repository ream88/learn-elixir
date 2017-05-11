defmodule ServyTest do
  use ExUnit.Case, async: true

  defp get(path) do
    Servy.Handler.handle("""
    GET #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """)
  end

  test "/wildthings" do
    response = get("/wildthings")
    assert response =~ "Bears, Lions, Tigers"
    assert response =~ "Content-Length: 20"
    assert response =~ "200 OK"
  end

  test "/international-wildthings" do
    response = get("/international-wildthings")
    assert response =~ "Beärs, Liöns, Tigers"
    assert response =~ "Content-Length: 22"
  end

  test "/bears" do
    response = get("/bears")
    assert response =~ "Teddy, Smokey, Paddington"
  end

  test "/bigfoot" do
    response = get("/bigfoot")
    assert response =~ "No /bigfoot found"
    assert response =~ "404 Not Found"
  end
end

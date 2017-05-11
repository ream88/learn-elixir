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

  defp delete(path) do
    Servy.Handler.handle("""
    DELETE #{path} HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """)
  end

  test "GET /wildthings" do
    response = get("/wildthings")
    assert response =~ "Bears, Lions, Tigers"
    assert response =~ "Content-Length: 20"
    assert response =~ "200 OK"
  end

  test "GET /international-wildthings" do
    response = get("/international-wildthings")
    assert response =~ "Beärs, Liöns, Tigers"
    assert response =~ "Content-Length: 22"
  end

  test "GET /bears" do
    response = get("/bears")
    assert response =~ "Teddy, Smokey, Paddington"
  end

  test "GET /bears/1" do
    response = get("/bears/1")
    assert response =~ "Teddy"
    assert response =~ "200 OK"
  end

  test "GET /bears/4" do
    response = get("/bears/4")
    assert response =~ "No bear with id 4 found"
    assert response =~ "404 Not Found"
  end

  test "GET /bigfoot" do
    response = get("/bigfoot")
    assert response =~ "No /bigfoot found"
    assert response =~ "404 Not Found"
  end

  test "GET /wildlife" do
    response = get("/wildlife")
    assert response =~ "Bears, Lions, Tigers"
  end

  test "GET /bears?id=1" do
    response = get("/bears?id=1")
    assert response =~ "Teddy"
    assert response =~ "200 OK"
  end

  test "DELETE /bears/1" do
    response = delete("/bears/1")
    assert response =~ "Deleting a bear is forbidden!"
    assert response =~ "403 Forbidden"
  end
end

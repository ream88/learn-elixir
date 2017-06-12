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

  defp post(path, body) do
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
    assert response =~ "Brutus, Kenai, Scarface"
  end

  test "GET /bears/1" do
    response = get("/bears/1")
    assert response =~ "Teddy"
    assert response =~ "200 OK"
  end

  test "GET /bears/3 is not index based" do
    response = get("/bears/3")
    assert response =~ "Paddington"
    assert response =~ "200 OK"
  end

  test "GET /bears/404" do
    response = get("/bears/404")
    assert response =~ "No bear with id 404 found"
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

  test "GET /pages/about.html" do
    response = get("/pages/about.html")
    assert response =~ "Hello World"
    assert response =~ "200 OK"
  end

  test "GET /pages/yeti.html" do
    response = get("/pages/yeti.html")
    assert response =~ "Page yeti.html not found"
    assert response =~ "404 Not Found"
  end

  # Arbitrary example, but I wanted to test 500s
  test "GET /pages/" do
    response = get("/pages/")
    assert response =~ "Internal Server Error (Reason: eisdir)"
    assert response =~ "500 Internal Server Error"
  end

  test "GET /pages/form.html" do
    response = get("/pages/form.html")
    assert response =~ "Create Bear"
    assert response =~ "200 OK"
  end

  test "POST /bears" do
    response = post("/bears", "name=Baloo&type=Brown")
    assert response =~ "A Brown bear named Baloo was created"
    assert response =~ "200 OK"
  end
end

defmodule ServyTest do
  use ExUnit.Case, async: true
  import TestHelper

  test "GET /wildthings" do
    response = get("/wildthings")
    assert response == """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """
  end

  test "GET /international-wildthings" do
    response = get("/international-wildthings")
    assert response =~ "Beärs, Liöns, Tigers"
    assert response =~ "Content-Length: 22"
  end

  test "GET /bears" do
    response = get("/bears")
    assert response =~ "<h1>All the bears!</h1>"
    assert response =~ "<li>Brutus</li>"
    assert response =~ "<li>Kenai</li>"
    assert response =~ "<li>Scarface</li>"
  end

  test "GET /bears/1" do
    response = get("/bears/1")
    assert response =~ "Teddy"
    assert response =~ "200 OK"
    assert response =~ "<h1>Show bear</h1>"
    assert response =~ "Is Teddy hibernating? <strong>true</strong>"
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
    assert response =~ "201 Created"
  end
end

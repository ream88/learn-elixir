defmodule ApiTest do
  use ExUnit.Case, async: true
  import TestHelper
  doctest Servy.Api.BearController

  defp remove_whitespace(string) do
    String.replace(string, ~r/\s/, "")
  end

  test "GET /api/bears returns list of bears" do
    response = get("/api/bears")
    assert response =~ "Content-Type: application/json"
    assert response =~ remove_whitespace("""
      [{
        "type": "Grizzly",
        "name": "Brutus",
        "id": 6,
        "hibernating": false
      }, {
        "type": "Polar",
        "name": "Iceman",
        "id": 9,
        "hibernating": true
      }, {
        "type": "Grizzly",
        "name": "Kenai",
        "id": 10,
        "hibernating": false
      }, {
        "type": "Brown",
        "name": "Paddington",
        "id": 3,
        "hibernating": false
      }, {
        "type": "Panda",
        "name": "Roscoe",
        "id": 8,
        "hibernating": false
      }, {
        "type": "Black",
        "name": "Rosie",
        "id": 7,
        "hibernating": true
      }, {
        "type": "Grizzly",
        "name": "Scarface",
        "id": 4,
        "hibernating": true
      }, {
        "type": "Black",
        "name": "Smokey",
        "id": 2,
        "hibernating": false
      }, {
        "type": "Polar",
        "name": "Snow",
        "id": 5,
        "hibernating": false
      }, {
        "type": "Brown",
        "name": "Teddy",
        "id": 1,
        "hibernating": true
      }]
    """)
  end

  test "POST /api/bears" do
    response = post("/api/bears", ~s({"name": "Breezly", "type": "Polar"}), "application/json")
    assert response == """
    HTTP/1.1 201 Created\r
    Content-Type: text/html\r
    Content-Length: 38\r
    \r
    A Polar bear named Breezly was created
    """
  end
end

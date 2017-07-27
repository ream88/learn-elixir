defmodule ApiTest do
  use ExUnit.Case, async: true
  import TestHelper
  doctest Servy.Api.BearController

  defp remove_whitespace(string) do
    String.replace(string, ~r/\s/, "")
  end

  test "/api/bears returns list of bears" do
    response = get("/api/bears")
    assert response =~ "Content-Type: application/json"
    assert response =~ remove_whitespace("""
      [{
        "type": "Grizzly",
        "name": "Brutus",
        "id": 6,
        "hibernating": true
      }, {
        "type": "Polar",
        "name": "Iceman",
        "id": 9,
        "hibernating": true
      }, {
        "type": "Grizzly",
        "name": "Kenai",
        "id": 10,
        "hibernating": true
      }, {
        "type": "Brown",
        "name": "Paddington",
        "id": 3,
        "hibernating": true
      }, {
        "type": "Panda",
        "name": "Roscoe",
        "id": 8,
        "hibernating": true
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
        "hibernating": true
      }, {
        "type": "Polar",
        "name": "Snow",
        "id": 5,
        "hibernating": true
      }, {
        "type": "Brown",
        "name": "Teddy",
        "id": 1,
        "hibernating": true
      }]
    """)
  end
end

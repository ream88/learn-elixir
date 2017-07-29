defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")
    [request_line | header_lines] = String.split(top, "\r\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      headers: headers,
      params: params
    }
  end

  @doc """
  Parses the given string of the form "application/x-www-form-urlencoded"
  into a map with corresponding keys and values.

  ## Examples

      iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", "one=1&two=2")
      %{"one" => "1", "two" => "2"}

  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  @doc """
  Parses the given string of the form "application/json"
  into a map with corresponding keys and values.

  ## Examples

      iex> Servy.Parser.parse_params("application/json", ~s({"one": "1", "two": "2"}))
      %{"one" => "1", "two" => "2"}

  """
  def parse_params("application/json", params_string) do
    Poison.Parser.parse!(params_string)
  end

  def parse_params(_, _), do: %{}

  @doc """
  Parses the given list of headers into a map.

  ## Examples

      iex> Servy.Parser.parse_headers(["Host: example.com", "Content-Type: application/json"])
      %{"Host" => "example.com", "Content-Type" => "application/json"}

  """
  def parse_headers(lines) do
    Enum.reduce(lines, %{}, &parse_header/2)
  end

  def parse_header(line, headers) do
    [key, value] = String.split(line, ": ")
    Map.put(headers, key, value)
  end
end

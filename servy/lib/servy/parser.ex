defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request_line | header_lines] = String.split(top, "\n")
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

  defp parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  defp parse_params(_, _), do: %{}

  defp parse_headers(lines) do
    Enum.reduce(lines, %{}, &parse_header/2)
  end

  defp parse_header(line, headers) do
    [key, value] = String.split(line, ": ")
    Map.put(headers, key, value)
  end
end

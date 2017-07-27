defmodule Servy.Conv do
  defstruct method: "",
            path: "",
            headers: %{},
            params: %{},
            body: "",
            response_headers: %{"Content-Type" => "text/html"},
            status: 200

  alias Servy.Conv

  def full_status(%Conv{} = conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end

  def content_length(%Conv{} = conv) do
    byte_size(conv.body)
  end
end

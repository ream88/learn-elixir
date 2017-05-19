require Logger

defmodule Servy.Plugins do
  def log(conv) do
    Logger.info inspect(conv)
    conv
  end

  def track(%{ status: 404, path: path } = conv) do
    Logger.error "Path #{path} not found!"
    conv
  end

  def track(conv), do: conv

  def rewrite_path(%{ method: "GET", path: "/wildlife" } = conv) do
    %{ conv | path: "/wildthings" }
  end

  def rewrite_path(%{ path: path } = conv) do
    regex = ~r{\/(?<resource>\w+)\?id=(?<id>\d)}
    captures = Regex.named_captures(regex, path)
    rewrite_named_captures(conv, captures)
  end

  defp rewrite_named_captures(conv, %{ "resource" => resource, "id" => id }) do
    Logger.warn "Rewriting #{conv.path} to /#{resource}/#{id}"
    %{ conv | path: "/#{resource}/#{id}" }
  end

  defp rewrite_named_captures(conv, _captures), do: conv
end

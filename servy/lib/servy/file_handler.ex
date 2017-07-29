defmodule Servy.FileHandler do
  def handle_file({:ok, content}, conv) do
    %{conv | body: content}
  end

  def handle_file({:error, :enoent}, %{path: "/pages/" <> page} = conv) do
    %{conv | status: 404, body: "Page #{page} not found"}
  end
end

defmodule Servy.FileHandler do
  def handle_file({:ok, content}, conv) do
    %{ conv | body: content }
  end

  def handle_file({:error, :enoent}, %{ path: "/pages/" <> page } = conv) do
    %{ conv | status: 404, body: "Page #{page} not found" }
  end

  def handle_file({:error, reason}, conv) do
    %{ conv | status: 500, body: "Internal Server Error (Reason: #{reason})" }
  end
end

defmodule Servy.HttpServer do
  alias Servy.Handler

  def start(port \\ 4000) do
    {:ok, server_socket} = :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])
    loop(server_socket)
  end

  defp loop(server_socket) do
    {:ok, client_socket} = :gen_tcp.accept(server_socket)
    serve(client_socket)
    loop(server_socket)
  end

  defp serve(client_socket) do
    client_socket
    |> read
    |> Handler.handle
    |> write(client_socket)
  end

  defp read(client_socket) do
    {:ok, request} = :gen_tcp.recv(client_socket, 0)
    request
  end

  defp write(response, client_socket) do
    :ok = :gen_tcp.send(client_socket, response)
    :ok = :gen_tcp.close(client_socket)
  end
end

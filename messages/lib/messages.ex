defmodule Messages do
  @moduledoc """
  A simple message server-client module.
  """
  use GenServer

  @doc """
  Starts the messages client.

      iex> {:ok, pid} = Messages.start
      iex> is_pid(pid)
      true
  """
  def start do
    state = []
    GenServer.start_link(__MODULE__, state)
  end

  @doc """
  Sends a message.

      iex> {:ok, pid} = Messages.start
      iex> Messages.send(pid, "Hey, how are you?")
      :ok
  """
  def send(pid, message) do
    GenServer.cast(pid, {:message, message})
  end

  @doc """
  Views all messages.

      iex> {:ok, pid} = Messages.start
      iex> Messages.view(pid)
      []

      iex> {:ok, pid} = Messages.start
      iex> Messages.send(pid, "Hey, how are you?")
      iex> Messages.view(pid)
      ["Hey, how are you?"]
  """
  def view(pid) do
    GenServer.call(pid, :view)
  end

  # Server
  def init(state) do
    {:ok, state}
  end

  @doc """
  Handles a incoming message.

      iex> Messages.handle_cast({:message, "Hey, how are you?"}, [])
      {:noreply, ["Hey, how are you?"]}
  """
  def handle_cast({:message, message}, state) do
    {:noreply, [message | state]}
  end

  @doc """
  Handles view calls.

      iex> Messages.handle_call(:view, nil, [])
      {:reply, [], []}

      iex> Messages.handle_call(:view, nil, ["Hey, how are you?"])
      {:reply, ["Hey, how are you?"], ["Hey, how are you?"]}
  """
  def handle_call(:view, _from, state) do
    {:reply, state, state}
  end
end

defmodule Fruits.Printer do
  use GenServer

  @fruits ["🍉", "🍊", "🌽", "🍒", "🍇", "🌶"]

  def init(_) do
    schedule()
    {:ok, []}
  end

  # Prints a random fruits.
  # This function may produce an out of bounds error,
  # but the supervisor will restart the process in the case.
  def print_fruit do
    @fruits
    |> Enum.fetch!(:rand.uniform(6))
    |> IO.puts
  end

  defp schedule() do
    Process.send_after(self(), :print_fruit, 500)
  end

  # GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [])
  end

  def handle_info(:print_fruit, state) do
    print_fruit()
    schedule()
    {:noreply, state}
  end
end

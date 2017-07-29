defmodule Timer do
  def remind(subject, seconds) do
    spawn(fn ->
      :timer.sleep seconds * 1000
      IO.puts subject
    end)
  end
end

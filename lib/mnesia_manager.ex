defmodule MnesiaManager do
  @moduledoc """
  Documentation for `MnesiaManager`.
  """

  @doc """
  This should only need to run the first time the application is installed.

  ## Examples

      iex> MnesiaManager.create_schema()
      :ok

  """
  def create_schema do
    with :stopped <- :mnesia.stop(),
         :ok <- create_mnesia_dir(),
         :ok <- :mnesia.create_schema([node() | Node.list()]) do
      :mnesia.start()
    end
  end

  def heartbeat do
    IO.puts("ok")
  end

  defp create_mnesia_dir do
    case File.exists?(mnesia_dir()) do
      true -> :ok
      false -> File.mkdir_p(mnesia_dir())
    end
  end

  defp mnesia_dir, do: Application.get_env(:mnesia, :dir)
end

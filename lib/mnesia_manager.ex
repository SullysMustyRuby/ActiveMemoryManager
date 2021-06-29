defmodule MnesiaManager do
  @moduledoc """
  Documentation for `MnesiaManager`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MnesiaManager.hello()
      :world

  """
  def create_schema do
    with :stopped <- :mnesia.stop(),
         :ok <- create_mnesia_dir(),
         :ok <- :mnesia.create_schema([node()]) do
      :mnesia.start()
    end
  end

  defp create_mnesia_dir do
    case File.exists?(mnesia_dir()) do
      true -> :ok
      false -> File.mkdir_p(mnesia_dir())
    end
  end

  defp mnesia_dir, do: Application.get_env(:mnesia, :dir)
end

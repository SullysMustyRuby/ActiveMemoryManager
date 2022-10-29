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
         :ok <- :mnesia.create_schema([node()]) do
      :mnesia.start()
    end
  end

  def recreate_schema do
    with :stopped <- :mnesia.stop(),
         :ok <- :mnesia.delete_schema([node()]),
         :ok <- :mnesia.create_schema([node()]) do
      :mnesia.start()
    end
  end

  def heartbeat do
    IO.puts("ok")
  end
end

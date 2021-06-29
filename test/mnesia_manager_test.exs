defmodule MnesiaManagerTest do
  use ExUnit.Case
  doctest MnesiaManager

  test "greets the world" do
    assert MnesiaManager.hello() == :world
  end
end

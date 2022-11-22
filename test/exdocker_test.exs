defmodule ExdockerTest do
  use ExUnit.Case
  doctest Exdocker

  test "greets the world" do
    assert Exdocker.hello() == :world
  end
end

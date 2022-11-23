defmodule Exdocker.SystemTest do
  use ExUnit.Case

  test "fetches version information" do
    assert "" == Exdocker.System.version()
  end
end

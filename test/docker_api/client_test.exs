defmodule Exdocker.ClientTest do
  use ExUnit.Case, async: true

  alias Exdocker.Client

  test "successfully integrates with docker daemon" do
    assert {:ok, %{status: 200, body: "OK"}} = Client.get("/_ping", %{})
  end
end

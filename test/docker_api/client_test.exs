defmodule Excontainers.DockerApi.ClientTest do
  use ExUnit.Case, async: true

  alias Excontainers.DockerApi.Client

  test "successfully integrates with docker daemon" do
    assert %{status: 200, body: "OK"} = Client.get("/_ping")
  end
end

defmodule Exdocker.ContextTest do
  use ExUnit.Case, async: false

  alias Exdocker.Context

  setup do
    previous_env = System.get_env()
    on_exit(fn -> System.put_env(previous_env) end)
  end

  describe "from_env/0" do
    test "defaults to /var/run/docker.sock" do
      System.delete_env("DOCKER_HOST")

      assert %Context{host: "unix:///var/run/docker.sock"} = Context.from_env()
    end

    test "detects configuration from environment" do
      System.put_env("DOCKER_HOST", "tcp://localhost:1234")

      assert %Context{host: "tcp://localhost:1234"} = Context.from_env()
    end
  end
end

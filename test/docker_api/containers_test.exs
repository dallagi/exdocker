defmodule Excontainers.DockerApi.ContainersTest do
  use ExUnit.Case, async: true

  alias Excontainers.DockerApi.Containers
  alias Excontainers.Support.{DockerTestUtils, TestUtils}

  @alpine "alpine:3.13.5"

  setup do
    DockerTestUtils.pull_image!(@alpine)
    :ok
  end

  describe "create" do
    test "creates a container from the given image" do
      container_name = "/" <> TestUtils.random_string()

      {:ok, container_id} = Containers.create(@alpine, name: container_name)
      on_exit(fn -> DockerTestUtils.remove_container!(container_id) end)

      container_info = DockerTestUtils.inspect!(container_id)
      assert @alpine == get_in(container_info, [Access.at(0), "Config", "Image"])
      assert container_name == get_in(container_info, [Access.at(0), "Name"])
    end
  end

  describe "start" do
    test "starts an existing container" do
      container_id = DockerTestUtils.create_container!(@alpine, ["sleep", "10"])

      assert :ok = Containers.start(container_id)
      assert "running" == DockerTestUtils.container_status(container_id)
    end
  end

  describe "wait" do
    test "waits until a container stops, then returns its exit code" do
      container_id = DockerTestUtils.run_container!(@alpine, ["sh", "-c", "sleep 0.5 && exit 123"])

      assert {:ok, 123} == Containers.wait(container_id)
    end
  end
end

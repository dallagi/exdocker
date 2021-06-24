defmodule Exdocker.ContainersTest do
  use ExUnit.Case, async: true

  alias Exdocker.Containers
  alias Exdocker.Support.{DockerTestUtils, TestUtils}

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

  describe "stream_logs" do
    test "streams logs as messages tagged with the stream type" do
      container_id =
        DockerTestUtils.run_container!(@alpine, [
          "sh",
          "-c",
          ~s(echo "hello stdout!" && echo "hello stderr!" >&2 && echo "hello stdout again!")
        ])

      assert {:ok, ref} = Containers.stream_logs(container_id, stdout: true, stderr: true)
      assert_receive({:log_chunk, ^ref, :stdout, "hello stdout!\n"})
      assert_receive({:log_chunk, ^ref, :stderr, "hello stderr!\n"})
      assert_receive({:log_chunk, ^ref, :stdout, "hello stdout again!\n"})
      assert_receive({:log_end, ^ref})
    end

    test "can filter streams" do
      container_id =
        DockerTestUtils.run_container!(@alpine, [
          "sh",
          "-c",
          ~s(echo "hello stdout!" && echo "hello stderr!" >&2)
        ])

      assert {:ok, ref} = Containers.stream_logs(container_id, stdout: true)
      assert_receive({:log_chunk, ^ref, :stdout, "hello stdout!\n"})
      refute_receive({:log_chunk, _, :stderr, _})
      assert_receive({:log_end, ^ref})
    end
  end

  describe "logs" do
    test "returns container logs" do
      container_id =
        DockerTestUtils.run_container!(@alpine, [
          "sh",
          "-c",
          ~s(echo "stdout!" && sleep "0.1" && echo "stderr!" >&2 && sleep "0.1" && echo "stdout again!")
        ])

      Containers.wait(container_id)

      assert {:ok, [{:stdout, "stdout!\n"}, {:stderr, "stderr!\n"}, {:stdout, "stdout again!\n"}]} =
               Containers.logs(container_id, stdout: true, stderr: true)
    end
  end
end

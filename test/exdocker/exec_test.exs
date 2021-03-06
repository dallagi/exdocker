defmodule ExecTest do
  use ExUnit.Case, async: true

  alias Exdocker.Support.DockerTestUtils
  alias Exdocker.Exec

  @alpine "alpine:3.13.5"

  setup do
    DockerTestUtils.pull_image!(@alpine)
    :ok
  end

  test "runs command inside running container and waits for it to finish" do
    container_id = DockerTestUtils.run_container!(@alpine, ["sleep", "10"])

    {:ok, exec_id} = Exec.create(container_id, ["sh", "-c", "sleep 0.2 && echo hello!"])

    assert {:ok, [{:stdout, "hello!\n"}]} = Exec.start(exec_id)
  end

  test "can stream exec logs" do
    container_id = DockerTestUtils.run_container!(@alpine, ["sleep", "10"])

    {:ok, exec_id} = Exec.create(container_id, ["sh", "-c", "echo first! && sleep 0.01 && echo second!"])
    {:ok, ref} = Exec.start_and_stream_logs(exec_id)

    assert_receive({:log_chunk, ^ref, :stdout, "first!\n"}, :timer.minutes(1))
    assert_receive({:log_chunk, ^ref, :stdout, "second!\n"}, :timer.minutes(1))
    assert_receive({:log_end, ^ref}, :timer.minutes(1))
  end
end

defmodule DockerApi.ExecTest do
  use ExUnit.Case

  alias Excontainers.Support.DockerTestUtils
  alias Excontainers.DockerApi.Exec

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
end

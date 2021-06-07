defmodule Excontainers.Support.DockerTestUtils do
  @moduledoc false

  def inspect!(id_or_name), do: run_command!(["inspect", id_or_name]) |> Jason.decode!()
  def pull_image!(name), do: run_command!(["pull", name])
  def remove_container!(id_or_name), do: run_command!(["rm", "-f", id_or_name])

  defp run_command!(command) do
    case System.cmd("docker", command) do
      {stdout, _exit_code = 0} -> stdout
      {_stdout, exit_code} -> raise "Command failed with exit code #{exit_code}"
    end
  end
end

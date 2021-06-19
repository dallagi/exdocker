defmodule Exdocker.Support.DockerTestUtils do
  @moduledoc false
  import ExUnit.Callbacks

  def create_container!(image, cmd \\ []) do
    container_id =
      run_command!(["create", image] ++ cmd)
      |> String.trim()

    on_exit(fn -> remove_container!(container_id) end)
    container_id
  end

  def run_container!(image, cmd \\ []) do
    container_id =
      run_command!(["run", "-d", image] ++ cmd)
      |> String.trim()

    on_exit(fn -> remove_container!(container_id) end)
    container_id
  end

  def inspect!(id_or_name), do: run_command!(["inspect", id_or_name]) |> Jason.decode!()
  def pull_image!(name), do: run_command!(["pull", name])
  def remove_container!(id_or_name), do: run_command!(["rm", "-f", id_or_name])

  def container_status(id_or_name), do: get_in(inspect!(id_or_name), [Access.at(0), "State", "Status"])

  defp run_command!(command) do
    case System.cmd("docker", command) do
      {stdout, _exit_code = 0} -> stdout
      {_stdout, exit_code} -> raise "Command failed with exit code #{exit_code}"
    end
  end
end

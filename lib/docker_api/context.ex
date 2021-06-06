defmodule Excontainers.DockerApi.Context do
  use TypedStruct

  @default_docker_host "unix:///var/run/docker.sock"

  typedstruct enforce: true do
    field :host, String.t()
    field :api_version, String.t()
  end

  def from_env do
    %__MODULE__{host: docker_host_from_env(), api_version: "v1.41"}
  end

  defp docker_host_from_env do
    System.get_env("DOCKER_HOST", @default_docker_host)
  end
end

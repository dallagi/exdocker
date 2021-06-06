defmodule Excontainers.DockerApi.Context do
  use TypedStruct

  @default_docker_host "unix:///var/run/docker.sock"

  typedstruct do
    field :host, String.t(), enforce: true
  end

  def from_env do
    %__MODULE__{host: docker_host_from_env()}
  end

  defp docker_host_from_env do
    System.get_env("DOCKER_HOST", @default_docker_host)
  end
end

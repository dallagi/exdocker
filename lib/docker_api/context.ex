defmodule Excontainers.DockerApi.Context do
  @moduledoc false
  use TypedStruct

  @default_docker_host "unix:///var/run/docker.sock"
  @api_version "v1.41"

  typedstruct enforce: true do
    @typedoc "Configuration necessary to communicate with the target docker daemon"

    field :host, String.t()
    field :api_version, String.t()
  end

  @doc """
  Build the context from environment variables

  Sensible defaults are adopted when environment variables are not set.
  The environment variables currently considered are:

  * `DOCKER_HOST`: daemon socket to connect to.
  """
  def from_env do
    %__MODULE__{host: docker_host_from_env(), api_version: @api_version}
  end

  defp docker_host_from_env do
    System.get_env("DOCKER_HOST", @default_docker_host)
  end
end

defmodule Exdocker.Context do
  @moduledoc false

  @default_docker_host "unix:///var/run/docker.sock"
  @api_version "v1.41"

  @enforce_keys [:host, :api_version]
  defstruct [:host, :api_version]

  @typedoc "Configuration necessary to communicate with the target docker daemon"
  @type t() :: %__MODULE__{host: String.t(), api_version: String.t()}

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

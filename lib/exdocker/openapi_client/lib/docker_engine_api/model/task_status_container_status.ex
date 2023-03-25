# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.TaskStatusContainerStatus do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :ContainerID,
    :PID,
    :ExitCode
  ]

  @type t :: %__MODULE__{
    :ContainerID => String.t | nil,
    :PID => integer() | nil,
    :ExitCode => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.TaskStatusContainerStatus do
  def decode(value, _options) do
    value
  end
end

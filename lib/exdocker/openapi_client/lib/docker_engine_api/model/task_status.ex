# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.TaskStatus do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Timestamp,
    :State,
    :Message,
    :Err,
    :ContainerStatus
  ]

  @type t :: %__MODULE__{
    :Timestamp => String.t | nil,
    :State => DockerEngineAPI.Model.TaskState.t | nil,
    :Message => String.t | nil,
    :Err => String.t | nil,
    :ContainerStatus => DockerEngineAPI.Model.TaskStatusContainerStatus.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.TaskStatus do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:State, :struct, DockerEngineAPI.Model.TaskState, options)
    |> deserialize(:ContainerStatus, :struct, DockerEngineAPI.Model.TaskStatusContainerStatus, options)
  end
end


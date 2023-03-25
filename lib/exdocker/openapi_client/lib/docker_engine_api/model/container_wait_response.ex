# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ContainerWaitResponse do
  @moduledoc """
  OK response to ContainerWait operation
  """

  @derive [Poison.Encoder]
  defstruct [
    :StatusCode,
    :Error
  ]

  @type t :: %__MODULE__{
    :StatusCode => integer(),
    :Error => DockerEngineAPI.Model.ContainerWaitExitError.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ContainerWaitResponse do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Error, :struct, DockerEngineAPI.Model.ContainerWaitExitError, options)
  end
end


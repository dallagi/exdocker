# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ContainerUpdateRequestAllOf do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :RestartPolicy
  ]

  @type t :: %__MODULE__{
    :RestartPolicy => DockerEngineAPI.Model.RestartPolicy.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ContainerUpdateRequestAllOf do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:RestartPolicy, :struct, DockerEngineAPI.Model.RestartPolicy, options)
  end
end


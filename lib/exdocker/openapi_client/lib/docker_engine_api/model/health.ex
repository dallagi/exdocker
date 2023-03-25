# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.Health do
  @moduledoc """
  Health stores information about the container's healthcheck results. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :Status,
    :FailingStreak,
    :Log
  ]

  @type t :: %__MODULE__{
    :Status => String.t | nil,
    :FailingStreak => integer() | nil,
    :Log => [DockerEngineAPI.Model.HealthcheckResult.t] | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.Health do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Log, :list, DockerEngineAPI.Model.HealthcheckResult, options)
  end
end


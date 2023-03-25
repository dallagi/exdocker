# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.NetworkingConfig do
  @moduledoc """
  NetworkingConfig represents the container's networking configuration for each of its interfaces. It is used for the networking configs specified in the `docker create` and `docker network connect` commands. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :EndpointsConfig
  ]

  @type t :: %__MODULE__{
    :EndpointsConfig => %{optional(String.t) => DockerEngineAPI.Model.EndpointSettings.t} | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.NetworkingConfig do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:EndpointsConfig, :map, DockerEngineAPI.Model.EndpointSettings, options)
  end
end


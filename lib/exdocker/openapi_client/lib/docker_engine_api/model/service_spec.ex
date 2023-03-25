# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ServiceSpec do
  @moduledoc """
  User modifiable configuration for a service.
  """

  @derive [Poison.Encoder]
  defstruct [
    :Name,
    :Labels,
    :TaskTemplate,
    :Mode,
    :UpdateConfig,
    :RollbackConfig,
    :Networks,
    :EndpointSpec
  ]

  @type t :: %__MODULE__{
    :Name => String.t | nil,
    :Labels => %{optional(String.t) => String.t} | nil,
    :TaskTemplate => DockerEngineAPI.Model.TaskSpec.t | nil,
    :Mode => DockerEngineAPI.Model.ServiceSpecMode.t | nil,
    :UpdateConfig => DockerEngineAPI.Model.ServiceSpecUpdateConfig.t | nil,
    :RollbackConfig => DockerEngineAPI.Model.ServiceSpecRollbackConfig.t | nil,
    :Networks => [DockerEngineAPI.Model.NetworkAttachmentConfig.t] | nil,
    :EndpointSpec => DockerEngineAPI.Model.EndpointSpec.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ServiceSpec do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:TaskTemplate, :struct, DockerEngineAPI.Model.TaskSpec, options)
    |> deserialize(:Mode, :struct, DockerEngineAPI.Model.ServiceSpecMode, options)
    |> deserialize(:UpdateConfig, :struct, DockerEngineAPI.Model.ServiceSpecUpdateConfig, options)
    |> deserialize(:RollbackConfig, :struct, DockerEngineAPI.Model.ServiceSpecRollbackConfig, options)
    |> deserialize(:Networks, :list, DockerEngineAPI.Model.NetworkAttachmentConfig, options)
    |> deserialize(:EndpointSpec, :struct, DockerEngineAPI.Model.EndpointSpec, options)
  end
end


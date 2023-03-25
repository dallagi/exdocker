# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.SwarmSpec do
  @moduledoc """
  User modifiable swarm configuration.
  """

  @derive [Poison.Encoder]
  defstruct [
    :Name,
    :Labels,
    :Orchestration,
    :Raft,
    :Dispatcher,
    :CAConfig,
    :EncryptionConfig,
    :TaskDefaults
  ]

  @type t :: %__MODULE__{
    :Name => String.t | nil,
    :Labels => %{optional(String.t) => String.t} | nil,
    :Orchestration => DockerEngineAPI.Model.SwarmSpecOrchestration.t | nil,
    :Raft => DockerEngineAPI.Model.SwarmSpecRaft.t | nil,
    :Dispatcher => DockerEngineAPI.Model.SwarmSpecDispatcher.t | nil,
    :CAConfig => DockerEngineAPI.Model.SwarmSpecCaConfig.t | nil,
    :EncryptionConfig => DockerEngineAPI.Model.SwarmSpecEncryptionConfig.t | nil,
    :TaskDefaults => DockerEngineAPI.Model.SwarmSpecTaskDefaults.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.SwarmSpec do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Orchestration, :struct, DockerEngineAPI.Model.SwarmSpecOrchestration, options)
    |> deserialize(:Raft, :struct, DockerEngineAPI.Model.SwarmSpecRaft, options)
    |> deserialize(:Dispatcher, :struct, DockerEngineAPI.Model.SwarmSpecDispatcher, options)
    |> deserialize(:CAConfig, :struct, DockerEngineAPI.Model.SwarmSpecCaConfig, options)
    |> deserialize(:EncryptionConfig, :struct, DockerEngineAPI.Model.SwarmSpecEncryptionConfig, options)
    |> deserialize(:TaskDefaults, :struct, DockerEngineAPI.Model.SwarmSpecTaskDefaults, options)
  end
end


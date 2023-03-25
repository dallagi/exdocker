# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.SwarmInfo do
  @moduledoc """
  Represents generic information about swarm. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :NodeID,
    :NodeAddr,
    :LocalNodeState,
    :ControlAvailable,
    :Error,
    :RemoteManagers,
    :Nodes,
    :Managers,
    :Cluster
  ]

  @type t :: %__MODULE__{
    :NodeID => String.t | nil,
    :NodeAddr => String.t | nil,
    :LocalNodeState => DockerEngineAPI.Model.LocalNodeState.t | nil,
    :ControlAvailable => boolean() | nil,
    :Error => String.t | nil,
    :RemoteManagers => [DockerEngineAPI.Model.PeerNode.t] | nil,
    :Nodes => integer() | nil,
    :Managers => integer() | nil,
    :Cluster => DockerEngineAPI.Model.ClusterInfo.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.SwarmInfo do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:LocalNodeState, :struct, DockerEngineAPI.Model.LocalNodeState, options)
    |> deserialize(:RemoteManagers, :list, DockerEngineAPI.Model.PeerNode, options)
    |> deserialize(:Cluster, :struct, DockerEngineAPI.Model.ClusterInfo, options)
  end
end

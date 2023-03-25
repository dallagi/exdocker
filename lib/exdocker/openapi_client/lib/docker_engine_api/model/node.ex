# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.Node do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :ID,
    :Version,
    :CreatedAt,
    :UpdatedAt,
    :Spec,
    :Description,
    :Status,
    :ManagerStatus
  ]

  @type t :: %__MODULE__{
    :ID => String.t | nil,
    :Version => DockerEngineAPI.Model.ObjectVersion.t | nil,
    :CreatedAt => String.t | nil,
    :UpdatedAt => String.t | nil,
    :Spec => DockerEngineAPI.Model.NodeSpec.t | nil,
    :Description => DockerEngineAPI.Model.NodeDescription.t | nil,
    :Status => DockerEngineAPI.Model.NodeStatus.t | nil,
    :ManagerStatus => DockerEngineAPI.Model.ManagerStatus.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.Node do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Version, :struct, DockerEngineAPI.Model.ObjectVersion, options)
    |> deserialize(:Spec, :struct, DockerEngineAPI.Model.NodeSpec, options)
    |> deserialize(:Description, :struct, DockerEngineAPI.Model.NodeDescription, options)
    |> deserialize(:Status, :struct, DockerEngineAPI.Model.NodeStatus, options)
    |> deserialize(:ManagerStatus, :struct, DockerEngineAPI.Model.ManagerStatus, options)
  end
end

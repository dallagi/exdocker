# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.PluginSettings do
  @moduledoc """
  Settings that can be modified by users.
  """

  @derive [Poison.Encoder]
  defstruct [
    :Mounts,
    :Env,
    :Args,
    :Devices
  ]

  @type t :: %__MODULE__{
    :Mounts => [DockerEngineAPI.Model.PluginMount.t],
    :Env => [String.t],
    :Args => [String.t],
    :Devices => [DockerEngineAPI.Model.PluginDevice.t]
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.PluginSettings do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Mounts, :list, DockerEngineAPI.Model.PluginMount, options)
    |> deserialize(:Devices, :list, DockerEngineAPI.Model.PluginDevice, options)
  end
end

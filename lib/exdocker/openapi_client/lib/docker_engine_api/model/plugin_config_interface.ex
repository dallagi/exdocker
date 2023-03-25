# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.PluginConfigInterface do
  @moduledoc """
  The interface between Docker and the plugin
  """

  @derive [Poison.Encoder]
  defstruct [
    :Types,
    :Socket,
    :ProtocolScheme
  ]

  @type t :: %__MODULE__{
    :Types => [DockerEngineAPI.Model.PluginInterfaceType.t],
    :Socket => String.t,
    :ProtocolScheme => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.PluginConfigInterface do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Types, :list, DockerEngineAPI.Model.PluginInterfaceType, options)
  end
end

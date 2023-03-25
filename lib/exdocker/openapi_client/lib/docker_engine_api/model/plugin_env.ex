# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.PluginEnv do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Name,
    :Description,
    :Settable,
    :Value
  ]

  @type t :: %__MODULE__{
    :Name => String.t,
    :Description => String.t,
    :Settable => [String.t],
    :Value => String.t
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.PluginEnv do
  def decode(value, _options) do
    value
  end
end

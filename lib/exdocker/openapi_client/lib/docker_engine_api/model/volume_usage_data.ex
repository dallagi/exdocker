# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.VolumeUsageData do
  @moduledoc """
  Usage details about the volume. This information is used by the `GET /system/df` endpoint, and omitted in other endpoints. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :Size,
    :RefCount
  ]

  @type t :: %__MODULE__{
    :Size => integer(),
    :RefCount => integer()
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.VolumeUsageData do
  def decode(value, _options) do
    value
  end
end


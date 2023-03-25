# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.DeviceMapping do
  @moduledoc """
  A device mapping between the host and container
  """

  @derive [Poison.Encoder]
  defstruct [
    :PathOnHost,
    :PathInContainer,
    :CgroupPermissions
  ]

  @type t :: %__MODULE__{
    :PathOnHost => String.t | nil,
    :PathInContainer => String.t | nil,
    :CgroupPermissions => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.DeviceMapping do
  def decode(value, _options) do
    value
  end
end


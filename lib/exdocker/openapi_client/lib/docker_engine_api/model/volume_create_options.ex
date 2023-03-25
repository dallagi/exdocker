# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.VolumeCreateOptions do
  @moduledoc """
  Volume configuration
  """

  @derive [Poison.Encoder]
  defstruct [
    :Name,
    :Driver,
    :DriverOpts,
    :Labels
  ]

  @type t :: %__MODULE__{
    :Name => String.t | nil,
    :Driver => String.t | nil,
    :DriverOpts => %{optional(String.t) => String.t} | nil,
    :Labels => %{optional(String.t) => String.t} | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.VolumeCreateOptions do
  def decode(value, _options) do
    value
  end
end


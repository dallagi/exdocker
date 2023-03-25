# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.VolumePruneResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :VolumesDeleted,
    :SpaceReclaimed
  ]

  @type t :: %__MODULE__{
    :VolumesDeleted => [String.t] | nil,
    :SpaceReclaimed => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.VolumePruneResponse do
  def decode(value, _options) do
    value
  end
end


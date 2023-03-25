# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ContainerPruneResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :ContainersDeleted,
    :SpaceReclaimed
  ]

  @type t :: %__MODULE__{
    :ContainersDeleted => [String.t] | nil,
    :SpaceReclaimed => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ContainerPruneResponse do
  def decode(value, _options) do
    value
  end
end

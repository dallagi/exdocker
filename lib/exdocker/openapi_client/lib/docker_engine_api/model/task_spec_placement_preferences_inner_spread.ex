# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.TaskSpecPlacementPreferencesInnerSpread do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :SpreadDescriptor
  ]

  @type t :: %__MODULE__{
    :SpreadDescriptor => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.TaskSpecPlacementPreferencesInnerSpread do
  def decode(value, _options) do
    value
  end
end


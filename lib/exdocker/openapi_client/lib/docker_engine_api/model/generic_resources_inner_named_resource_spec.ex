# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.GenericResourcesInnerNamedResourceSpec do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Kind,
    :Value
  ]

  @type t :: %__MODULE__{
    :Kind => String.t | nil,
    :Value => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.GenericResourcesInnerNamedResourceSpec do
  def decode(value, _options) do
    value
  end
end


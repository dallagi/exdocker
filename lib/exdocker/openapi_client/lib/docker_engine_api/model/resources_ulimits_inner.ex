# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ResourcesUlimitsInner do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Name,
    :Soft,
    :Hard
  ]

  @type t :: %__MODULE__{
    :Name => String.t | nil,
    :Soft => integer() | nil,
    :Hard => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ResourcesUlimitsInner do
  def decode(value, _options) do
    value
  end
end


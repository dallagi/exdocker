# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ServiceUpdateResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Warnings
  ]

  @type t :: %__MODULE__{
    :Warnings => [String.t] | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ServiceUpdateResponse do
  def decode(value, _options) do
    value
  end
end


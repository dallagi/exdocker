# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ErrorDetail do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :code,
    :message
  ]

  @type t :: %__MODULE__{
    :code => integer() | nil,
    :message => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ErrorDetail do
  def decode(value, _options) do
    value
  end
end


# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.Platform do
  @moduledoc """
  Platform represents the platform (Arch/OS). 
  """

  @derive [Poison.Encoder]
  defstruct [
    :Architecture,
    :OS
  ]

  @type t :: %__MODULE__{
    :Architecture => String.t | nil,
    :OS => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.Platform do
  def decode(value, _options) do
    value
  end
end


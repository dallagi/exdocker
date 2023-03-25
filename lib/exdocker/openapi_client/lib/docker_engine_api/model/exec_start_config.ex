# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ExecStartConfig do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Detach,
    :Tty
  ]

  @type t :: %__MODULE__{
    :Detach => boolean() | nil,
    :Tty => boolean() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ExecStartConfig do
  def decode(value, _options) do
    value
  end
end


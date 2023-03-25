# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ServiceUpdateStatus do
  @moduledoc """
  The status of a service update.
  """

  @derive [Poison.Encoder]
  defstruct [
    :State,
    :StartedAt,
    :CompletedAt,
    :Message
  ]

  @type t :: %__MODULE__{
    :State => String.t | nil,
    :StartedAt => String.t | nil,
    :CompletedAt => String.t | nil,
    :Message => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ServiceUpdateStatus do
  def decode(value, _options) do
    value
  end
end

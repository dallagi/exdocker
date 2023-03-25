# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.EventActor do
  @moduledoc """
  Actor describes something that generates events, like a container, network, or a volume. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :ID,
    :Attributes
  ]

  @type t :: %__MODULE__{
    :ID => String.t | nil,
    :Attributes => %{optional(String.t) => String.t} | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.EventActor do
  def decode(value, _options) do
    value
  end
end

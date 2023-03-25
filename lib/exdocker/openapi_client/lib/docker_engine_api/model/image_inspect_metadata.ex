# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ImageInspectMetadata do
  @moduledoc """
  Additional metadata of the image in the local cache. This information is local to the daemon, and not part of the image itself. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :LastTagTime
  ]

  @type t :: %__MODULE__{
    :LastTagTime => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ImageInspectMetadata do
  def decode(value, _options) do
    value
  end
end

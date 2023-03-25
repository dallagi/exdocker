# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.SecretSpec do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Name,
    :Labels,
    :Data,
    :Driver,
    :Templating
  ]

  @type t :: %__MODULE__{
    :Name => String.t | nil,
    :Labels => %{optional(String.t) => String.t} | nil,
    :Data => String.t | nil,
    :Driver => DockerEngineAPI.Model.Driver.t | nil,
    :Templating => DockerEngineAPI.Model.Driver.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.SecretSpec do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Driver, :struct, DockerEngineAPI.Model.Driver, options)
    |> deserialize(:Templating, :struct, DockerEngineAPI.Model.Driver, options)
  end
end


# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.GenericResourcesInner do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :NamedResourceSpec,
    :DiscreteResourceSpec
  ]

  @type t :: %__MODULE__{
    :NamedResourceSpec => DockerEngineAPI.Model.GenericResourcesInnerNamedResourceSpec.t | nil,
    :DiscreteResourceSpec => DockerEngineAPI.Model.GenericResourcesInnerDiscreteResourceSpec.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.GenericResourcesInner do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:NamedResourceSpec, :struct, DockerEngineAPI.Model.GenericResourcesInnerNamedResourceSpec, options)
    |> deserialize(:DiscreteResourceSpec, :struct, DockerEngineAPI.Model.GenericResourcesInnerDiscreteResourceSpec, options)
  end
end


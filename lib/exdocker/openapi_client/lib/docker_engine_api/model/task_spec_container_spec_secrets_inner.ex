# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.TaskSpecContainerSpecSecretsInner do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :File,
    :SecretID,
    :SecretName
  ]

  @type t :: %__MODULE__{
    :File => DockerEngineAPI.Model.TaskSpecContainerSpecSecretsInnerFile.t | nil,
    :SecretID => String.t | nil,
    :SecretName => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.TaskSpecContainerSpecSecretsInner do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:File, :struct, DockerEngineAPI.Model.TaskSpecContainerSpecSecretsInnerFile, options)
  end
end

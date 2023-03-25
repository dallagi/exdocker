# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.TaskSpecContainerSpecPrivilegesCredentialSpec do
  @moduledoc """
  CredentialSpec for managed service account (Windows only)
  """

  @derive [Poison.Encoder]
  defstruct [
    :Config,
    :File,
    :Registry
  ]

  @type t :: %__MODULE__{
    :Config => String.t | nil,
    :File => String.t | nil,
    :Registry => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.TaskSpecContainerSpecPrivilegesCredentialSpec do
  def decode(value, _options) do
    value
  end
end


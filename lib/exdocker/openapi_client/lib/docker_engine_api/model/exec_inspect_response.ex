# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ExecInspectResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :CanRemove,
    :DetachKeys,
    :ID,
    :Running,
    :ExitCode,
    :ProcessConfig,
    :OpenStdin,
    :OpenStderr,
    :OpenStdout,
    :ContainerID,
    :Pid
  ]

  @type t :: %__MODULE__{
    :CanRemove => boolean() | nil,
    :DetachKeys => String.t | nil,
    :ID => String.t | nil,
    :Running => boolean() | nil,
    :ExitCode => integer() | nil,
    :ProcessConfig => DockerEngineAPI.Model.ProcessConfig.t | nil,
    :OpenStdin => boolean() | nil,
    :OpenStderr => boolean() | nil,
    :OpenStdout => boolean() | nil,
    :ContainerID => String.t | nil,
    :Pid => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ExecInspectResponse do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:ProcessConfig, :struct, DockerEngineAPI.Model.ProcessConfig, options)
  end
end


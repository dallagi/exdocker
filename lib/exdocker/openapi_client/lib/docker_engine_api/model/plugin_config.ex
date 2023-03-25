# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.PluginConfig do
  @moduledoc """
  The config of a plugin.
  """

  @derive [Poison.Encoder]
  defstruct [
    :DockerVersion,
    :Description,
    :Documentation,
    :Interface,
    :Entrypoint,
    :WorkDir,
    :User,
    :Network,
    :Linux,
    :PropagatedMount,
    :IpcHost,
    :PidHost,
    :Mounts,
    :Env,
    :Args,
    :rootfs
  ]

  @type t :: %__MODULE__{
    :DockerVersion => String.t | nil,
    :Description => String.t,
    :Documentation => String.t,
    :Interface => DockerEngineAPI.Model.PluginConfigInterface.t,
    :Entrypoint => [String.t],
    :WorkDir => String.t,
    :User => DockerEngineAPI.Model.PluginConfigUser.t | nil,
    :Network => DockerEngineAPI.Model.PluginConfigNetwork.t,
    :Linux => DockerEngineAPI.Model.PluginConfigLinux.t,
    :PropagatedMount => String.t,
    :IpcHost => boolean(),
    :PidHost => boolean(),
    :Mounts => [DockerEngineAPI.Model.PluginMount.t],
    :Env => [DockerEngineAPI.Model.PluginEnv.t],
    :Args => DockerEngineAPI.Model.PluginConfigArgs.t,
    :rootfs => DockerEngineAPI.Model.PluginConfigRootfs.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.PluginConfig do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Interface, :struct, DockerEngineAPI.Model.PluginConfigInterface, options)
    |> deserialize(:User, :struct, DockerEngineAPI.Model.PluginConfigUser, options)
    |> deserialize(:Network, :struct, DockerEngineAPI.Model.PluginConfigNetwork, options)
    |> deserialize(:Linux, :struct, DockerEngineAPI.Model.PluginConfigLinux, options)
    |> deserialize(:Mounts, :list, DockerEngineAPI.Model.PluginMount, options)
    |> deserialize(:Env, :list, DockerEngineAPI.Model.PluginEnv, options)
    |> deserialize(:Args, :struct, DockerEngineAPI.Model.PluginConfigArgs, options)
    |> deserialize(:rootfs, :struct, DockerEngineAPI.Model.PluginConfigRootfs, options)
  end
end


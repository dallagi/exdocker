# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.HostConfigAllOf do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :Binds,
    :ContainerIDFile,
    :LogConfig,
    :NetworkMode,
    :PortBindings,
    :RestartPolicy,
    :AutoRemove,
    :VolumeDriver,
    :VolumesFrom,
    :Mounts,
    :CapAdd,
    :CapDrop,
    :CgroupnsMode,
    :Dns,
    :DnsOptions,
    :DnsSearch,
    :ExtraHosts,
    :GroupAdd,
    :IpcMode,
    :Cgroup,
    :Links,
    :OomScoreAdj,
    :PidMode,
    :Privileged,
    :PublishAllPorts,
    :ReadonlyRootfs,
    :SecurityOpt,
    :StorageOpt,
    :Tmpfs,
    :UTSMode,
    :UsernsMode,
    :ShmSize,
    :Sysctls,
    :Runtime,
    :ConsoleSize,
    :Isolation,
    :MaskedPaths,
    :ReadonlyPaths
  ]

  @type t :: %__MODULE__{
    :Binds => [String.t] | nil,
    :ContainerIDFile => String.t | nil,
    :LogConfig => DockerEngineAPI.Model.HostConfigAllOfLogConfig.t | nil,
    :NetworkMode => String.t | nil,
    :PortBindings => %{optional(String.t) => [DockerEngineAPI.Model.PortBinding.t]} | nil,
    :RestartPolicy => DockerEngineAPI.Model.RestartPolicy.t | nil,
    :AutoRemove => boolean() | nil,
    :VolumeDriver => String.t | nil,
    :VolumesFrom => [String.t] | nil,
    :Mounts => [DockerEngineAPI.Model.Mount.t] | nil,
    :CapAdd => [String.t] | nil,
    :CapDrop => [String.t] | nil,
    :CgroupnsMode => String.t | nil,
    :Dns => [String.t] | nil,
    :DnsOptions => [String.t] | nil,
    :DnsSearch => [String.t] | nil,
    :ExtraHosts => [String.t] | nil,
    :GroupAdd => [String.t] | nil,
    :IpcMode => String.t | nil,
    :Cgroup => String.t | nil,
    :Links => [String.t] | nil,
    :OomScoreAdj => integer() | nil,
    :PidMode => String.t | nil,
    :Privileged => boolean() | nil,
    :PublishAllPorts => boolean() | nil,
    :ReadonlyRootfs => boolean() | nil,
    :SecurityOpt => [String.t] | nil,
    :StorageOpt => %{optional(String.t) => String.t} | nil,
    :Tmpfs => %{optional(String.t) => String.t} | nil,
    :UTSMode => String.t | nil,
    :UsernsMode => String.t | nil,
    :ShmSize => integer() | nil,
    :Sysctls => %{optional(String.t) => String.t} | nil,
    :Runtime => String.t | nil,
    :ConsoleSize => [integer()] | nil,
    :Isolation => String.t | nil,
    :MaskedPaths => [String.t] | nil,
    :ReadonlyPaths => [String.t] | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.HostConfigAllOf do
  import DockerEngineAPI.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:LogConfig, :struct, DockerEngineAPI.Model.HostConfigAllOfLogConfig, options)
    |> deserialize(:RestartPolicy, :struct, DockerEngineAPI.Model.RestartPolicy, options)
    |> deserialize(:Mounts, :list, DockerEngineAPI.Model.Mount, options)
  end
end

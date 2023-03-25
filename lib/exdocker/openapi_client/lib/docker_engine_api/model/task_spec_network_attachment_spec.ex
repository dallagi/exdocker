# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.TaskSpecNetworkAttachmentSpec do
  @moduledoc """
  Read-only spec type for non-swarm containers attached to swarm overlay networks.  <p><br /></p>  > **Note**: ContainerSpec, NetworkAttachmentSpec, and PluginSpec are > mutually exclusive. PluginSpec is only used when the Runtime field > is set to `plugin`. NetworkAttachmentSpec is used when the Runtime > field is set to `attachment`. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :ContainerID
  ]

  @type t :: %__MODULE__{
    :ContainerID => String.t | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.TaskSpecNetworkAttachmentSpec do
  def decode(value, _options) do
    value
  end
end

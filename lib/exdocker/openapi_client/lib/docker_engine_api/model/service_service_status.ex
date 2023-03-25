# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.ServiceServiceStatus do
  @moduledoc """
  The status of the service's tasks. Provided only when requested as part of a ServiceList operation. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :RunningTasks,
    :DesiredTasks,
    :CompletedTasks
  ]

  @type t :: %__MODULE__{
    :RunningTasks => integer() | nil,
    :DesiredTasks => integer() | nil,
    :CompletedTasks => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.ServiceServiceStatus do
  def decode(value, _options) do
    value
  end
end


# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Model.BuildCache do
  @moduledoc """
  BuildCache contains information about a build cache record. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :ID,
    :Parent,
    :Type,
    :Description,
    :InUse,
    :Shared,
    :Size,
    :CreatedAt,
    :LastUsedAt,
    :UsageCount
  ]

  @type t :: %__MODULE__{
    :ID => String.t | nil,
    :Parent => String.t | nil,
    :Type => String.t | nil,
    :Description => String.t | nil,
    :InUse => boolean() | nil,
    :Shared => boolean() | nil,
    :Size => integer() | nil,
    :CreatedAt => String.t | nil,
    :LastUsedAt => String.t | nil,
    :UsageCount => integer() | nil
  }
end

defimpl Poison.Decoder, for: DockerEngineAPI.Model.BuildCache do
  def decode(value, _options) do
    value
  end
end


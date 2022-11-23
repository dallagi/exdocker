defmodule Exdocker.ClientGenerator.Definition do
  alias Exdocker.ClientGenerator.Definition

  @type t :: Definition.Object.t() | Definition.Array.t() | Definition.String.t()

  @spec parse(map()) :: Object.t()
  def parse(openapi_spec) do
    case openapi_spec["type"] do
      "object" ->
        Definition.Object.parse(openapi_spec)

      "array" ->
        Definition.Array.parse(openapi_spec)

      "string" ->
        Definition.String.parse(openapi_spec)

      "boolean" ->
        Definition.Boolean.parse(openapi_spec)
    end
  end
end

defmodule Exdocker.ClientGenerator.Definition.Object do
  alias Exdocker.ClientGenerator.Definition

  @type t :: %__MODULE__{
          properties: map(),
          description: String.t(),
          required: list(String.t()),
          nullable: boolean()
        }
  defstruct ~w(properties description required nullable)a

  def parse(%{"properties" => properties} = openapi_spec) do
    %__MODULE__{
      properties: parse_properties(properties),
      description: openapi_spec["description"],
      required: Map.get(openapi_spec, "required", []),
      nullable: Map.get(openapi_spec, "x-nullable", true)
    }
  end

  defp parse_properties(properties_spec) do
    for {property_name, property_spec} <- properties_spec,
        into: %{},
        do: {property_name, Definition.parse(property_spec)}
  end
end

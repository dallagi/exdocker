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

  def to_struct(self, name) do
    property_names = Map.keys(self.properties)

    quote do
      defmodule unquote(name) do
        defstruct unquote(property_names)
      end
    end
  end

  defp parse_properties(properties_spec) do
    for {property_name, property_spec} <- properties_spec,
        into: %{},
        do: {String.to_atom(property_name), Definition.parse(property_spec)}
  end
end

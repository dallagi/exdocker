defmodule Exdocker.ClientGenerator.Definition.Array do
  alias Exdocker.ClientGenerator.Definition

  @type t :: %__MODULE__{items: Definition.t(), description: String.t(), nullable: boolean()}
  defstruct ~w(items description nullable)a

  def parse(%{items: items} = openapi_spec) do
    %__MODULE__{
      items: items,
      description: openapi_spec["description"],
      nullable: Map.get(openapi_spec, "x-nullable", true)
    }
  end
end

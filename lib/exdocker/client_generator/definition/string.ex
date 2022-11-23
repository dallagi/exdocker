defmodule Exdocker.ClientGenerator.Definition.String do
  @type t :: %__MODULE__{description: String.t(), example: String.t(), nullable: boolean()}
  defstruct ~w(description example nullable)a

  def parse(%{} = openapi_spec) do
    %__MODULE__{
      description: openapi_spec["description"],
      example: openapi_spec["example"],
      nullable: openapi_spec["x-nullable"]
    }
  end
end

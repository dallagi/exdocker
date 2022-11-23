defmodule Exdocker.ClientGenerator.DefinitionTest do
  use ExUnit.Case
  alias Exdocker.ClientGenerator.Definition

  test "parses empty object" do
    spec = %{
      "type" => "object",
      "description" => "description for test object",
      "properties" => %{}
    }

    assert %Definition.Object{
             properties: %{},
             description: "description for test object",
             required: [],
             nullable: true
           } == Definition.Object.parse(spec)
  end

  test "parses object with simple fields" do
    spec = %{
      "type" => "object",
      "description" => "description for test object",
      "properties" => %{"Property1" => %{"type" => "string"}}
    }

    assert %Definition.Object{
             properties: %{Property1: %Definition.String{nullable: true}},
             description: "description for test object",
             required: [],
             nullable: true
           } == Definition.Object.parse(spec)
  end

  test "parses object with nested object" do
    spec = %{
      "type" => "object",
      "description" => "description for test object",
      "properties" => %{"Property1" => %{"type" => "object", "properties" => %{}}}
    }

    assert %Definition.Object{
             properties: %{
               Property1: %Definition.Object{
                 properties: %{},
                 description: nil,
                 required: [],
                 nullable: true
               }
             },
             description: "description for test object",
             required: [],
             nullable: true
           } == Definition.Object.parse(spec)
  end

  # test "xxx" do
  #   api_spec = YamlElixir.read_from_file!("priv/docker-api-v1.41.yaml")
  #   dbg(Definition.parse(api_spec["definitions"]["SystemVersion"]))
  # end

  test "generate simple struct" do
    definition = %Definition.Object{
      properties: %{:Property1 => %Definition.String{}},
      description: "description for test object",
      required: [],
      nullable: true
    }

    generated = Macro.to_string(Definition.Object.to_struct(definition, :TestObject))

    expected =
      """
      defmodule :TestObject do
        defstruct [:Property1]
      end
      """
      |> String.trim()

    assert expected == generated
  end

  test "generate nested structs" do
    definition = %Definition.Object{
      properties: %{
        Property1: %Definition.Object{
          properties: %{},
          description: nil,
          required: [],
          nullable: true
        }
      },
      description: "description for test object",
      required: [],
      nullable: true
    }

    generated = Macro.to_string(Definition.Object.to_struct(definition, :TestObject))

    # TODO
    assert """
           """ == generated
  end
end

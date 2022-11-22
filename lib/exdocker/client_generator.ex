defmodule Exdocker.ClientGenerator do
  defmacro __using__(params) do
    path = params[:spec_path]
    api_spec = YamlElixir.read_from_file!(path)

    Module.put_attribute(__CALLER__.module, :api_spec, api_spec)

    quote do
      import Exdocker.ClientGenerator
      nil
    end
  end

  defmacro defendpoint(name, operation_id) do
    api_spec = Module.get_attribute(__CALLER__.module, :api_spec)
    base_path = api_spec["basePath"]

    operation_spec =
      api_spec
      |> all_operations()
      |> Enum.find(fn op -> op.id == operation_id end)

    method = method_for(operation_spec)

    quote do
      def unquote(name)() do
        Finch.build(
          unquote(method),
          "http://localhost" <> unquote(base_path) <> unquote(operation_spec.path),
          %{},
          nil,
          unix_socket: "/var/run/docker.sock"
        )
        |> IO.inspect()
        |> Finch.request(ExDocker.Finch)
      end
    end
  end

  defp all_operations(api_spec) do
    paths = api_spec["paths"]

    for {path, path_spec} <- paths,
        method <- Map.keys(path_spec),
        operation_spec = paths[path][method],
        operation_id = operation_spec["operationId"],
        do: %{path: path, method: method, spec: operation_spec, id: operation_id}
  end

  defp method_for(%{method: method} = _operation_spec) do
    case method do
      "get" -> :get
      "post" -> :post
    end
  end
end

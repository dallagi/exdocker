defmodule Excontainers.DockerApi.Exec do
  alias Excontainers.DockerApi.{Client, Logs}
  alias Excontainers.Utils.{ExtraEnum, ExtraKeyword}

  @type result(result_type) :: {:ok, result_type} | {:error, any()}

  @spec create(String.t(), [String.t()], Keyword.t()) :: result(String.t())
  def create(container_id, command, options \\ []) do
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])

    environment =
      options
      |> Keyword.get(:environment, [])
      |> to_env()

    body =
      ExtraEnum.remove_nils(%{
        AttachStdin: Keyword.get(options, :attach_stdin, false),
        AttachStdout: Keyword.get(options, :attach_stdout, true),
        AttachStderr: Keyword.get(options, :attach_stderr, true),
        Privileged: Keyword.get(options, :privileged, false),
        User: Keyword.get(options, :user),
        WorkingDir: Keyword.get(options, :working_dir),
        Tty: false,
        Cmd: command,
        Env: environment
      })

    case Client.post("/containers/#{container_id}/exec", body, %{}, client_options) do
      {:ok, %{status: 201, body: %{"Id" => exec_id}}} -> {:ok, exec_id}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec start(String.t(), Keyword.t()) :: result([{Logs.std_stream(), String.t()}])
  def start(exec_id, options \\ []) do
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])
    body = %{Detach: Keyword.get(options, :detach, false)}

    case Client.post("/exec/#{exec_id}/start", body, %{}, client_options) do
      {:ok, %{status: 200, body: body}} -> {:ok, Logs.parse_chunk(body)}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec start_and_stream_logs(String.t(), Keyword.t()) :: result(reference())
  def start_and_stream_logs(exec_id, options \\ []) do
    stream_to = Keyword.get(options, :stream_to, self())
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])
    body = %{Detach: false}

    logs_listener = spawn_link(fn -> Logs.parse_and_forward(stream_to) end)

    case Client.post_stream("/exec/#{exec_id}/start", body, %{}, logs_listener, client_options) do
      {:ok, %{status: 200, stream_ref: stream_ref}} ->
        {:ok, stream_ref}

      {:ok, %{status: status}} ->
        Process.exit(logs_listener, :request_failed)
        {:error, "Request failed with status #{status}"}

      {:error, error} ->
        Process.exit(logs_listener, :request_failed)
        {:error, error}
    end
  end

  defp to_env(environment) when is_list(environment), do: environment
  defp to_env(environment) when is_map(environment), do: Enum.map(environment, fn {key, value} -> "#{key}=#{value}" end)
end

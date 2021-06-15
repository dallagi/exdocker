defmodule Excontainers.DockerApi.Containers do
  @moduledoc false

  alias Excontainers.DockerApi.Client
  alias Excontainers.Utils.{ExtraEnum, ExtraKeyword}

  @spec create(String.t(), Keyword.t()) :: {:ok, String.t() | {:error, any()}}
  def create(image, options \\ []) do
    client_options = ExtraKeyword.take_values(options, [:context])
    [name, command, host_config] = ExtraKeyword.take_values(options, [:name, :command, :host_config])
    extra_params = Keyword.get(options, :extra_params, %{})

    body = create_body(image, command, host_config, extra_params)

    case Client.post("/containers/create", body, %{name: name}, client_options) do
      {:ok, %{status: 201, body: %{"Id" => container_id}}} -> {:ok, container_id}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec start(String.t(), Keyword.t()) :: :ok | {:error, any()}
  def start(container_id, options \\ []) do
    client_options = ExtraKeyword.take_values(options, [:context])

    case Client.post("/containers/#{container_id}/start", "", %{}, client_options) do
      {:ok, %{status: 204}} -> :ok
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec wait(String.t(), Keyword.t()) :: {:ok, non_neg_integer()} | {:error, any()}
  def wait(container_id, options \\ []) do
    condition = Keyword.get(options, :condition, "not-running")
    client_options = ExtraKeyword.take_values(options, [:context])

    case Client.post("/containers/#{container_id}/wait", "", %{condition: condition}, client_options) do
      {:ok, %{status: 200, body: %{"StatusCode" => exit_code}}} -> {:ok, exit_code}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec stream_logs(String.t(), Keyword.t()) :: {:ok, reference()} | {:error, any()}
  def stream_logs(container_id, options \\ []) do
    stream_to = Keyword.get(options, :stream_to, self())
    stdout = Keyword.get(options, :stdout, true)
    stderr = Keyword.get(options, :stderr, false)
    client_options = ExtraKeyword.take_values(options, [:context])

    query_params = %{follow: true, stdout: stdout, stderr: stderr}
    logs_listener = spawn_link(fn -> parse_and_forward_logs(stream_to) end)
    response = Client.get_stream("/containers/#{container_id}/logs", query_params, logs_listener, client_options)

    case response do
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

  @spec logs(String.t(), Keyword.t()) :: {:ok, String.t()} | {:error, any()}
  def logs(container_id, options \\ []) do
    client_options = ExtraKeyword.take_values(options, [:context])
    stdout = Keyword.get(options, :stdout, true)
    stderr = Keyword.get(options, :stderr, false)

    query_params = %{follow: false, stdout: stdout, stderr: stderr}

    case Client.get("/containers/#{container_id}/logs", query_params, client_options) do
      {:ok, %{status: 200, body: raw_logs}} -> {:ok, parse_logs(raw_logs)}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  defp create_body(image, command, host_config, extra_params) do
    %{
      "Cmd" => command,
      "Image" => image,
      "HostConfig" => host_config
    }
    |> Map.merge(extra_params)
    |> ExtraEnum.remove_nils()
  end

  defp parse_and_forward_logs(forward_to) do
    receive do
      {:chunk, ref, chunk} ->
        for {stream, text} <- parse_log_chunk(chunk) do
          send(forward_to, {:log_chunk, ref, stream, text})
        end

        parse_and_forward_logs(forward_to)

      {:end, ref} ->
        send(forward_to, {:log_end, ref})
    end
  end

  defp parse_logs(chunk) do
    chunk
    |> parse_log_chunk
    |> Enum.group_by(fn {stream, _text} -> stream end, fn {_stream, text} -> text end)
    |> Enum.map(fn {stream, text_list} -> {stream, Enum.join(text_list)} end)
    |> Enum.into(%{})
  end

  defp parse_log_chunk(<<>>), do: []

  defp parse_log_chunk(chunk) do
    <<stream_id, 0, 0, 0, size::32, text::binary-size(size), rest::binary>> = chunk

    stream =
      case stream_id do
        0 -> :stdin
        1 -> :stdout
        2 -> :stderr
      end

    [{stream, text} | parse_log_chunk(rest)]
  end
end

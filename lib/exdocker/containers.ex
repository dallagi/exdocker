defmodule Exdocker.Containers do
  @moduledoc false

  alias Exdocker.Client
  alias Exdocker.Utils.Logs
  alias Exdocker.Utils.{ExtraEnum, ExtraKeyword}

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
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])

    case Client.post("/containers/#{container_id}/start", "", %{}, client_options) do
      {:ok, %{status: 204}} -> :ok
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec wait(String.t(), Keyword.t()) :: {:ok, non_neg_integer()} | {:error, any()}
  def wait(container_id, options \\ []) do
    condition = Keyword.get(options, :condition, "not-running")
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])

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
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])

    query_params = %{follow: true, stdout: stdout, stderr: stderr}

    logs_listener = spawn_link(fn -> Logs.parse_and_forward(stream_to) end)

    case Client.get_stream("/containers/#{container_id}/logs", query_params, logs_listener, client_options) do
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

  @spec logs(String.t(), Keyword.t()) :: {:ok, [Logs.log_chunk()]} | {:error, any()}
  def logs(container_id, options \\ []) do
    client_options = ExtraKeyword.take_values(options, [:context, :timeout])
    stdout = Keyword.get(options, :stdout, true)
    stderr = Keyword.get(options, :stderr, false)

    query_params = %{follow: false, stdout: stdout, stderr: stderr}

    case Client.get("/containers/#{container_id}/logs", query_params, client_options) do
      {:ok, %{status: 200, body: raw_logs}} -> {:ok, Logs.parse_chunk(raw_logs)}
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
end

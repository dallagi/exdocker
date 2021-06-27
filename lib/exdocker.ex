defmodule Exdocker do
  @moduledoc false

  use TypedStruct
  require Logger

  alias Exdocker.Client
  alias Exdocker.Utils.{ExtraEnum, ExtraKeyword}

  def check_auth(options) do
    [user, password, email, server_address] =
      ExtraKeyword.take_values(options, [:user, :password, :email, :server_address])

    client_options = Keyword.take(options, [:context, :timeout])
    body = ExtraEnum.remove_nils(%{username: user, password: password, email: email, serveraddress: server_address})

    case Client.post("/auth", body, %{}, client_options) do
      {:ok, %{status: 200, body: %{"IdentityToken" => id_token}}} -> {:ok, id_token}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  def stream_events(options \\ []) do
    stream_to = Keyword.get(options, :stream_to, self())
    client_options = Keyword.take(options, [:context, :timeout])

    [since, until, filters] = ExtraKeyword.take_values(options, [:since, :until, :filters])
    encoded_since = if since != nil, do: DateTime.to_unix(since)
    encoded_until = if until != nil, do: DateTime.to_unix(until)
    encoded_filters = if filters != nil, do: Jason.encode!(filters), else: nil

    query_params = ExtraEnum.remove_nils(%{since: encoded_since, until: encoded_until, filters: encoded_filters})
    events_listener = spawn_link(fn -> parse_and_forward_events(stream_to) end)

    case Client.get_stream("/events", query_params, events_listener, client_options) do
      {:ok, %{status: 200, stream_ref: stream_ref}} ->
        {:ok, stream_ref}

      {:ok, %{status: status}} ->
        Process.exit(events_listener, :request_failed)
        {:error, "Request failed with status #{status}"}

      {:error, error} ->
        Process.exit(events_listener, :request_failed)
        {:error, error}
    end
  end

  def ping(options \\ []) do
    client_options = Keyword.take(options, [:context, :timeout])

    case Client.get("/_ping", %{}, client_options) do
      {:ok, %{status: 200}} -> :ok
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  defp parse_and_forward_events(forward_to) do
    receive do
      {:chunk, ref, chunk} ->
        case Jason.decode(chunk) do
          {:ok, event} -> send(forward_to, {:event, ref, event})
          {:error, error} -> Logger.warning("Received malformed event", chunk: chunk, error: error)
        end

        parse_and_forward_events(forward_to)

      {:end, ref} ->
        send(forward_to, {:events_end, ref})
        :ok
    end
  end
end

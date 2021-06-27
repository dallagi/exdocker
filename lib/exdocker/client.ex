defmodule Exdocker.Client do
  @moduledoc false

  require Logger
  alias Exdocker.Context

  @type query_params :: map()
  @type request_body :: String.t() | map()
  @type response :: {:ok, __MODULE__.Response.t()} | {:error, any()}
  @type async_response :: {:ok, __MODULE__.AsyncResponse.t()} | {:error, any()}

  @timeout :timer.hours(1_000)

  defmodule Response do
    @enforce_keys [:status, :body]
    defstruct [:status, :body]

    @typedoc "HTTP Response"
    @type t() :: %__MODULE__{status: pos_integer(), body: term()}
  end

  defmodule AsyncResponse do
    @enforce_keys [:status, :stream_ref]
    defstruct [:status, :stream_ref]

    @typedoc "Async HTTP Response"
    @type t() :: %__MODULE__{status: pos_integer(), stream_ref: reference()}
  end

  @spec get(String.t(), map(), Keyword.t()) :: response()
  def get(path, query_params, options \\ []) do
    request(:get, path, query_params, "", options)
  end

  @spec get_stream(String.t(), map(), pid(), Keyword.t()) :: async_response()
  def get_stream(path, query_params, stream_to, options \\ []) do
    async_request(:get, path, query_params, "", stream_to, options)
  end

  @spec post(String.t(), request_body(), query_params(), Keyword.t()) :: response()
  def post(path, body, query_params, options \\ []) do
    request(:post, path, query_params, body, options)
  end

  @spec post_stream(String.t(), map(), pid(), Keyword.t()) :: async_response()
  def post_stream(path, body, query_params, stream_to, options \\ []) do
    async_request(:post, path, query_params, body, stream_to, options)
  end

  defp request(method, path, query_params, body, options) do
    context = Keyword.get(options, :context, Context.from_env())
    raw_response = Keyword.get(options, :raw_response, false)
    url = base_url(context) <> path
    headers = if is_map(body), do: %{"Content-Type" => "application/json"}, else: %{}
    body = if is_map(body), do: Jason.encode!(body), else: body

    Logger.debug("Sending request", method: method, url: url, context: context)

    response = HTTPoison.request(method, url, body, headers, params: query_params)

    with {:ok, %HTTPoison.Response{status_code: status, body: body, headers: headers}} <- response,
         {:ok, parsed_body} <- parse_body(body, headers, raw_response) do
      {:ok, %__MODULE__.Response{status: status, body: parsed_body}}
    end
  end

  defp async_request(method, path, query_params, body, stream_to, options) do
    context = Keyword.get(options, :context, Context.from_env())
    url = base_url(context) <> path
    headers = if is_map(body), do: %{"Content-Type" => "application/json"}, else: %{}
    body = if is_map(body), do: Jason.encode!(body), else: body

    Logger.debug("Sending async request", method: method, url: url, context: context)

    parent = self()
    listener_pid = spawn_link(fn -> stream_listener(parent, stream_to) end)

    result = HTTPoison.request(method, url, body, headers, params: query_params, stream_to: listener_pid)

    with {:ok, %HTTPoison.AsyncResponse{id: ref}} <- result do
      receive do
        {:status, ^ref, status_code} -> {:ok, %AsyncResponse{status: status_code, stream_ref: ref}}
      after
        @timeout -> {:error, :timeout_waiting_status}
      end
    end
  end

  defp base_url(context) do
    hackney_host =
      case context.host do
        "tcp://" <> tcp_socket -> "http://" <> tcp_socket
        "unix://" <> unix_socket -> "http+unix://" <> URI.encode_www_form(unix_socket)
      end

    "#{hackney_host}/#{context.api_version}"
  end

  defp parse_body(body, _, true), do: {:ok, body}

  defp parse_body(body, headers, false) do
    case Enum.into(headers, %{}) do
      %{"Content-Type" => "application/json"} -> Jason.decode(body)
      _ -> {:ok, body}
    end
  end

  defp stream_listener(parent, stream_to) do
    receive do
      %HTTPoison.AsyncStatus{code: code, id: id} ->
        send(parent, {:status, id, code})
        stream_listener(parent, stream_to)

      %HTTPoison.AsyncChunk{chunk: chunk, id: id} ->
        send(stream_to, {:chunk, id, chunk})
        stream_listener(parent, stream_to)

      %HTTPoison.AsyncEnd{id: id} ->
        send(stream_to, {:end, id})
    end
  end
end

defmodule Excontainers.DockerApi.Client do
  @moduledoc false

  use TypedStruct
  require Logger
  alias Excontainers.DockerApi.Context

  @type query_params :: map()
  @type request_body :: String.t() | map()
  @type response :: {:ok, __MODULE__.Response.t()} | {:error, any()}

  typedstruct module: Response, enforce: true do
    field :status, pos_integer()
    field :body, term()
  end

  @spec get(String.t(), Keyword.t()) :: response()
  def get(path, query_params, options \\ []) do
    request(:get, path, query_params, "", options)
  end

  @spec post(String.t(), request_body(), query_params(), Keyword.t()) :: response()
  def post(path, body, query_params, options \\ []) do
    request(:post, path, query_params, body, options)
  end

  defp request(method, path, query_params, body, options) do
    context = Keyword.get(options, :context, Context.from_env())
    url = base_url(context) <> path

    Logger.info("Sending request", method: method, url: url, context: context)

    headers = if is_map(body), do: %{"Content-Type" => "application/json"}, else: %{}
    body = if is_map(body), do: Jason.encode!(body), else: body

    response = HTTPoison.request(method, url, body, headers, params: query_params)

    with {:ok, %HTTPoison.Response{status_code: status, body: body, headers: headers}} <- response,
         {:ok, parsed_body} <- parse_body(body, Enum.into(headers, %{})["Content-Type"]) do
      {:ok, %__MODULE__.Response{status: status, body: parsed_body}}
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

  defp parse_body(body, "application/json"), do: Jason.decode(body)
  defp parse_body(body, _), do: {:ok, body}
end

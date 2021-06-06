defmodule Excontainers.DockerApi.Client do
  use TypedStruct
  require Logger
  alias Excontainers.DockerApi.Context

  typedstruct module: Response, enforce: true do
    field :status, pos_integer()
    field :body, term()
  end

  @spec get(String.t(), Keyword.t()) :: __MODULE__.Response.t()
  def get(path, options \\ []) do
    request(:get, path, options)
  end

  defp request(method, path, options) do
    context = Keyword.get(options, :context, Context.from_env())
    url = base_url(context) <> path

    Logger.info("Sending request", method: method, url: url, context: context)

    response =
      HTTPoison.request(
        method,
        url
      )

    with {:ok, %HTTPoison.Response{status_code: status, body: body, headers: _headers}} = response do
      %__MODULE__.Response{status: status, body: body}
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
end

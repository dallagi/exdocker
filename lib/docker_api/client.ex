defmodule Excontainers.DockerApi.Client do
  require Logger
  alias Excontainers.DockerApi.Context

  def get(path, options \\ []) do
    request(:get, path, options)
  end

  defp request(method, path, options) do
    context = Keyword.get(options, :context, Context.from_env())
    Logger.info("Sending #{method} request to #{base_url(context) <> path}")

    response =
      HTTPoison.request(
        method,
        base_url(context) <> path
      )

    with {:ok, %HTTPoison.Response{status_code: status, body: body, headers: _headers}} = response do
      %{status: status, body: body}
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

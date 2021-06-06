defmodule Excontainers.DockerApi.Containers do
  @moduledoc false

  alias Excontainers.DockerApi.Client

  @spec create(String.t(), Keyword.t()) :: {:ok, String.t() | {:error, any()}}
  def create(image, options \\ []) do
    name = Keyword.get(options, :name)
    extra_params = Keyword.get(options, :extra_params, %{})
    client_options = Keyword.take(options, [:context])

    command = Keyword.get(options, :command)
    host_config = Keyword.get(options, :host_config)

    body = create_body(image, command, host_config, extra_params)

    case Client.post("/containers/create", body, %{name: name}, client_options) do
      {:ok, %{status: 201, body: %{"Id" => container_id}}} -> {:ok, container_id}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end

  @spec start(String.t(), Keyword.t()) :: :ok | {:error, any()}
  def start(container_id, options \\ []) do
    client_options = Keyword.take(options, [:context])

    case Client.post("/containers/#{container_id}/start", "", %{}, client_options) do
      {:ok, %{status: 204}} -> :ok
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
    |> remove_nils()
  end

  defp remove_nils(enum) do
    enum
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end

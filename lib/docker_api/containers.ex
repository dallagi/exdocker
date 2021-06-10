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

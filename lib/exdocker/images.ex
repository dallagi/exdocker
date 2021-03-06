defmodule Exdocker.Images do
  @moduledoc false

  alias Exdocker.Client

  def pull(image, tag \\ "latest", options \\ []) do
    client_options =
      Keyword.take(options, [:context, :timeout])
      |> Keyword.put(:raw_response, true)

    tag = if tag == :all, do: nil, else: tag
    params = %{fromImage: image, tag: tag}

    case Client.post("/images/create", "", params, client_options) do
      {:ok, %{status: 200}} -> :ok
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end
end

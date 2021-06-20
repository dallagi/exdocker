defmodule Exdocker do
  @moduledoc false
  alias Exdocker.Client
  alias Exdocker.Utils.{ExtraEnum, ExtraKeyword}

  def check_auth(options) do
    [user, password, email, server_address] =
      ExtraKeyword.take_values(options, [:user, :password, :email, :server_address])

    client_options = ExtraKeyword.take_values(options, [:context, :timeout])
    body = ExtraEnum.remove_nils(%{username: user, password: password, email: email, serveraddress: server_address})

    case Client.post("/auth", body, %{}, client_options) do
      {:ok, %{status: 200, body: %{"IdentityToken" => id_token}}} -> {:ok, id_token}
      {:ok, %{status: status}} -> {:error, "Request failed with status #{status}"}
      {:error, error} -> {:error, error}
    end
  end
end

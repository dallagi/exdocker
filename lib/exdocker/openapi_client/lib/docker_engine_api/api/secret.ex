# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Api.Secret do
  @moduledoc """
  API calls for all endpoints tagged `Secret`.
  """

  alias DockerEngineAPI.Connection
  import DockerEngineAPI.RequestBuilder

  @doc """
  Create a secret

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `opts` (keyword): Optional parameters
    - `:body` (SecretCreateRequest): 

  ### Returns

  - `{:ok, DockerEngineAPI.Model.IdResponse.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec secret_create(Tesla.Env.client, keyword()) :: {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:ok, DockerEngineAPI.Model.IdResponse.t} | {:error, Tesla.Env.t}
  def secret_create(connection, opts \\ []) do
    optional_params = %{
      :body => :body
    }

    request =
      %{}
      |> method(:post)
      |> url("/secrets/create")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, %DockerEngineAPI.Model.IdResponse{}},
      {409, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Delete a secret

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): ID of the secret
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec secret_delete(Tesla.Env.client, String.t, keyword()) :: {:ok, nil} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def secret_delete(connection, id, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url("/secrets/#{id}")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Inspect a secret

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): ID of the secret
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, DockerEngineAPI.Model.Secret.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec secret_inspect(Tesla.Env.client, String.t, keyword()) :: {:ok, DockerEngineAPI.Model.Secret.t} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def secret_inspect(connection, id, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/secrets/#{id}")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, %DockerEngineAPI.Model.Secret{}},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  List secrets

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `opts` (keyword): Optional parameters
    - `:filters` (String.t): A JSON encoded value of the filters (a `map[string][]string`) to process on the secrets list.  Available filters:  - `id=<secret id>` - `label=<key> or label=<key>=value` - `name=<secret name>` - `names=<secret name>` 

  ### Returns

  - `{:ok, [%Secret{}, ...]}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec secret_list(Tesla.Env.client, keyword()) :: {:ok, list(DockerEngineAPI.Model.Secret.t)} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def secret_list(connection, opts \\ []) do
    optional_params = %{
      :filters => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/secrets")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, [%DockerEngineAPI.Model.Secret{}]},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Update a Secret

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): The ID or name of the secret
  - `version` (integer()): The version number of the secret object being updated. This is required to avoid conflicting writes. 
  - `opts` (keyword): Optional parameters
    - `:body` (SecretSpec): The spec of the secret to update. Currently, only the Labels field can be updated. All other fields must remain unchanged from the [SecretInspect endpoint](#operation/SecretInspect) response values. 

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec secret_update(Tesla.Env.client, String.t, integer(), keyword()) :: {:ok, nil} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def secret_update(connection, id, version, opts \\ []) do
    optional_params = %{
      :body => :body
    }

    request =
      %{}
      |> method(:post)
      |> url("/secrets/#{id}/update")
      |> add_param(:query, :version, version)
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, false},
      {400, %DockerEngineAPI.Model.ErrorResponse{}},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end
end
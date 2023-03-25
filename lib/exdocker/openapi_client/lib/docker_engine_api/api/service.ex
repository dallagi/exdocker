# NOTE: This file is auto generated by OpenAPI Generator 6.2.1 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule DockerEngineAPI.Api.Service do
  @moduledoc """
  API calls for all endpoints tagged `Service`.
  """

  alias DockerEngineAPI.Connection
  import DockerEngineAPI.RequestBuilder

  @doc """
  Create a service

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `body` (ServiceCreateRequest): 
  - `opts` (keyword): Optional parameters
    - `:"X-Registry-Auth"` (String.t): A base64url-encoded auth configuration for pulling from private registries.  Refer to the [authentication section](#section/Authentication) for details. 

  ### Returns

  - `{:ok, DockerEngineAPI.Model.ServiceCreateResponse.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec service_create(Tesla.Env.client, DockerEngineAPI.Model.ServiceCreateRequest.t, keyword()) :: {:ok, DockerEngineAPI.Model.ServiceCreateResponse.t} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def service_create(connection, body, opts \\ []) do
    optional_params = %{
      :"X-Registry-Auth" => :headers
    }

    request =
      %{}
      |> method(:post)
      |> url("/services/create")
      |> add_param(:body, :body, body)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, %DockerEngineAPI.Model.ServiceCreateResponse{}},
      {400, %DockerEngineAPI.Model.ErrorResponse{}},
      {403, %DockerEngineAPI.Model.ErrorResponse{}},
      {409, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Delete a service

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): ID or name of service.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec service_delete(Tesla.Env.client, String.t, keyword()) :: {:ok, nil} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def service_delete(connection, id, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url("/services/#{id}")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, false},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Inspect a service

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): ID or name of service.
  - `opts` (keyword): Optional parameters
    - `:insertDefaults` (boolean()): Fill empty fields with default values.

  ### Returns

  - `{:ok, DockerEngineAPI.Model.Service.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec service_inspect(Tesla.Env.client, String.t, keyword()) :: {:ok, DockerEngineAPI.Model.Service.t} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def service_inspect(connection, id, opts \\ []) do
    optional_params = %{
      :insertDefaults => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/services/#{id}")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, %DockerEngineAPI.Model.Service{}},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  List services

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `opts` (keyword): Optional parameters
    - `:filters` (String.t): A JSON encoded value of the filters (a `map[string][]string`) to process on the services list.  Available filters:  - `id=<service id>` - `label=<service label>` - `mode=[\"replicated\"|\"global\"]` - `name=<service name>` 
    - `:status` (boolean()): Include service status, with count of running and desired tasks. 

  ### Returns

  - `{:ok, [%Service{}, ...]}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec service_list(Tesla.Env.client, keyword()) :: {:ok, list(DockerEngineAPI.Model.Service.t)} | {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def service_list(connection, opts \\ []) do
    optional_params = %{
      :filters => :query,
      :status => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/services")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, [%DockerEngineAPI.Model.Service{}]},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Get service logs
  Get `stdout` and `stderr` logs from a service. See also [`/containers/{id}/logs`](#operation/ContainerLogs).  **Note**: This endpoint works only for services with the `local`, `json-file` or `journald` logging drivers. 

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): ID or name of the service
  - `opts` (keyword): Optional parameters
    - `:details` (boolean()): Show service context and extra details provided to logs.
    - `:follow` (boolean()): Keep connection after returning logs.
    - `:stdout` (boolean()): Return logs from `stdout`
    - `:stderr` (boolean()): Return logs from `stderr`
    - `:since` (integer()): Only return logs since this time, as a UNIX timestamp
    - `:timestamps` (boolean()): Add timestamps to every log line
    - `:tail` (String.t): Only return this number of log lines from the end of the logs. Specify as an integer or `all` to output all log lines. 

  ### Returns

  - `{:ok, String.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec service_logs(Tesla.Env.client, String.t, keyword()) :: {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:ok, String.t} | {:error, Tesla.Env.t}
  def service_logs(connection, id, opts \\ []) do
    optional_params = %{
      :details => :query,
      :follow => :query,
      :stdout => :query,
      :stderr => :query,
      :since => :query,
      :timestamps => :query,
      :tail => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/services/#{id}/logs")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, false},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Update a service

  ### Parameters

  - `connection` (DockerEngineAPI.Connection): Connection to server
  - `id` (String.t): ID or name of service.
  - `version` (integer()): The version number of the service object being updated. This is required to avoid conflicting writes. This version number should be the value as currently set on the service *before* the update. You can find the current version by calling `GET /services/{id}` 
  - `body` (ServiceUpdateRequest): 
  - `opts` (keyword): Optional parameters
    - `:registryAuthFrom` (String.t): If the `X-Registry-Auth` header is not specified, this parameter indicates where to find registry authorization credentials. 
    - `:rollback` (String.t): Set to this parameter to `previous` to cause a server-side rollback to the previous service spec. The supplied spec will be ignored in this case. 
    - `:"X-Registry-Auth"` (String.t): A base64url-encoded auth configuration for pulling from private registries.  Refer to the [authentication section](#section/Authentication) for details. 

  ### Returns

  - `{:ok, DockerEngineAPI.Model.ServiceUpdateResponse.t}` on success
  - `{:error, Tesla.Env.t}` on failure
  """
  @spec service_update(Tesla.Env.client, String.t, integer(), DockerEngineAPI.Model.ServiceUpdateRequest.t, keyword()) :: {:ok, DockerEngineAPI.Model.ErrorResponse.t} | {:ok, DockerEngineAPI.Model.ServiceUpdateResponse.t} | {:error, Tesla.Env.t}
  def service_update(connection, id, version, body, opts \\ []) do
    optional_params = %{
      :registryAuthFrom => :query,
      :rollback => :query,
      :"X-Registry-Auth" => :headers
    }

    request =
      %{}
      |> method(:post)
      |> url("/services/#{id}/update")
      |> add_param(:query, :version, version)
      |> add_param(:body, :body, body)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, %DockerEngineAPI.Model.ServiceUpdateResponse{}},
      {400, %DockerEngineAPI.Model.ErrorResponse{}},
      {404, %DockerEngineAPI.Model.ErrorResponse{}},
      {500, %DockerEngineAPI.Model.ErrorResponse{}},
      {503, %DockerEngineAPI.Model.ErrorResponse{}}
    ])
  end
end
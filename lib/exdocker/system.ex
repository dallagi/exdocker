defmodule Exdocker.System do
  use Exdocker.ClientGenerator, spec_path: "priv/docker-api-v1.41.yaml"

  defendpoint(:version, "SystemVersion")
end

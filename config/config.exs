import Config

config :logger, :console,
  format: "[$level] $message $metadata\n",
  metadata: :all

try do
  import_config "#{config_env()}.exs"
catch
  _, _ -> nil
end

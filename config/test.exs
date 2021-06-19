import Config

config :logger, :console,
  level: :warning,
  format: "[$level] $message $metadata\n",
  metadata: :all

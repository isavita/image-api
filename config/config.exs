# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :image_api,
  ecto_repos: [ImageApi.Repo]

# Configures the endpoint
config :image_api, ImageApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PDCe5mAf90T0owI56Sz+R55PSZLzeqqCF6g97uMgOh24wwJ+6t8HQtbbT7gpHSeB",
  render_errors: [view: ImageApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ImageApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

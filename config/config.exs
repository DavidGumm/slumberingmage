# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :slumberingmage,
  ecto_repos: [Slumberingmage.Repo]

# Configures the endpoint
config :slumberingmage, SlumberingmageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bQPsfvwGyw2nDVdKpWT7R43JC5KfylruQVGrs4WpIx/47NQQPXRXgpXWXpiCI++w",
  render_errors: [view: SlumberingmageWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Slumberingmage.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

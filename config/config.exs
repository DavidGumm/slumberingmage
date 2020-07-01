# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :slumberingmage,
  ecto_repos: [Slumberingmage.Repo]

  config :phoenix, :template_engines,
  md: PhoenixMarkdown.Engine

# Configures the endpoint
config :slumberingmage, SlumberingmageWeb.Endpoint,
  http: [port: 4000],
  secret_key_base: "bQPsfvwGyw2nDVdKpWT7R43JC5KfylruQVGrs4WpIx/47NQQPXRXgpXWXpiCI++w",
  render_errors: [view: SlumberingmageWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Slumberingmage.PubSub, adapter: Phoenix.PubSub.PG2],
  json_library: Jason

# Configures Elixir's Logger
config :logger,
format: "\n##### $time $metadata[$level] $levelpad$message\n",
backends: [:console],
compile_time_purge_matching: [
  [level_lower_than: :debug]
]

# Our Console Backend-specific configuration
config :logger, :console,
format: "\n##### $time $metadata[$level] $levelpad$message\n",
metadata: :all

config :slumberingmage, Slumberingmage.UserManager.Guardian,
  allowed_algos: ["HS512"],
  issuer: "slumberingmage",
  secret_key: "Z/Sd24XcYp4pNdcwiSobyXCLrGZVgrqeI5r5Xi8LDBvXHYzAC9xoNdM4/swEwRNa",
  token_ttl: %{
    "magic" => {30, :minutes},
    "access" => {1, :days}
  }

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :slumberingmage, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      param_nesting: "user",
      request_path: "/register",
      callback_path: "/register",
      callback_methods: ["POST"]
    ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

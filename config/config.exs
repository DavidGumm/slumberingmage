# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :deusexlog,
  ecto_repos: [Deusexlog.Repo]

config :phoenix, :template_engines, md: PhoenixMarkdown.Engine


secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

secret_key =
  System.get_env("GUARDIAN_SECRET_KEY") ||
    raise """
    environment variable SECRET_KEY is missing.
    You can generate one by calling: mix phx.gen.secret
    """

# Configures the endpoint
config :deusexlog, DeusexlogWeb.Endpoint,
  http: [port: 4000],
  secret_key_base: secret_key_base, #"bQPsfvwGyw2nDVdKpWT7R43JC5KfylruQVGrs4WpIx/47NQQPXRXgpXWXpiCI++w"
  render_errors: [view: DeusexlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Deusexlog.PubSub, adapter: Phoenix.PubSub.PG2],
  json_library: Jason

# Configures Elixir's Logger
config :logger,
  format: "\n[$level] [$date $time] $levelpad$message$levelpad$metadata\n",
  metadata: :all,
  compile_time_purge_matching: [
    [level_lower_than: :debug]
  ]

config :deusexlog, Deusexlog.UserManager.Guardian,
  allowed_algos: ["HS512"],
  issuer: "deusexlog",
  secret_key: secret_key, #"Z/Sd24XcYp4pNdcwiSobyXCLrGZVgrqeI5r5Xi8LDBvXHYzAC9xoNdM4/swEwRNa"
  token_ttl: %{
    "magic" => {30, :minutes},
    "access" => {1, :days}
  }

config :deusexlog, DeusexlogWeb.Authentication,
  issuer: "deusexlog",
  secret_key: secret_key
  #"Z/Sd24XcYp4pNdcwiSobyXCLrGZVgrqeI5r5Xi8LDBvXHYzAC9xoNdM4/swEwRNa"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []},
    identity:
      {Ueberauth.Strategy.Identity,
       [
         param_nesting: "user",
         request_path: "/register",
         callback_path: "/register",
         callback_methods: ["POST"]
       ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

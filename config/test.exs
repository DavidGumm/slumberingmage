use Mix.Config

# Configure your database
config :deusexlog, Deusexlog.Repo,
  username: "postgres",
  password: "postgres",
  database: "deusexlog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :deusexlog, DeusexlogWeb.Endpoint, server: false

# Print only warnings and errors during test
config :logger, level: :warn

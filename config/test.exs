use Mix.Config

# Configure your database
config :slumberingmage, Slumberingmage.Repo,
  username: "postgres",
  password: "Tru9qYluKvM*1dizOuOnVx%Z07GaVhx2",
  database: "slumberingmage_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :slumberingmage, SlumberingmageWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

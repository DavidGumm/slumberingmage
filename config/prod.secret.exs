# In this file, we load production configuration and
# secrets from environment variables. You can also
# hardcode secrets, although such is generally not
# recommended and you have to remember to add this
# file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :deusexlog, Deusexlog.Repo,
  # ssl: true,
  url: database_url,
  config :deusexlog, Deusexlog.Repo,

  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE"),

  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :deusexlog, DeusexlogWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# force_ssl: [hsts: true],
# url: [host: "black-left-oropendula.gigalixirapp.com", port: 443],
# http: [:inet6, port: 80],
# https: [
#   :inet6,
#   port: 443,
#   cipher_suite: :strong
# ],
# http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
# secret_key_base: secret_key_base

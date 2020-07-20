defmodule Deusexlog.Repo do
  use Ecto.Repo,
    otp_app: :deusexlog,
    adapter: Ecto.Adapters.Postgres
end

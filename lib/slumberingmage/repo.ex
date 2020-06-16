defmodule Slumberingmage.Repo do
  use Ecto.Repo,
    otp_app: :slumberingmage,
    adapter: Ecto.Adapters.Postgres
end

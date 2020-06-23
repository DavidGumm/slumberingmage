defmodule Slumberingmage do
  @moduledoc """
  Slumberingmage keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
end

defmodule Slumberingmage.Vault do
  use Cloak.Vault, otp_app: :Slumberingmage
end

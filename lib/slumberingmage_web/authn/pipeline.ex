defmodule SlumberingmageWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :slumberingmage,
    error_handler: SlumberingmageWeb.Authentication.ErrorHandler,
    module: SlumberingmageWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end

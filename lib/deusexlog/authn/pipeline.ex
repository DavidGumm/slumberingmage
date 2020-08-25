defmodule DeusexlogWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :deusexlog,
    error_handler: DeusexlogWeb.Authentication.ErrorHandler,
    module: DeusexlogWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end

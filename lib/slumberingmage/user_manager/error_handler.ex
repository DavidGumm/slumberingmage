defmodule Slumberingmage.UserManager.ErrorHandler do
  import Plug.Conn
  import Phoenix.HTML
  require Logger

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    Logger.debug "#{to_string(type)}"
    body = raw("<h1>#{to_string(type)}</h1>")
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end

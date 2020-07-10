defmodule Slumberingmage.UserManager.ErrorHandler do
  use SlumberingmageWeb, :controller
  alias Slumberingmage.{UserManager, UserManager.User, UserManager.Guardian}

  import Plug.Conn
  import Phoenix.HTML
  require Logger

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    Logger.debug("#{to_string(type)}")
    body = raw("<h1>#{to_string(type)}</h1>")
    #
    # Start Test
    # Force cookie experation, and redirect to login page.
    Plug.Conn.Cookies.encode("expires=Thu, 01 Jan 1970 00:00:00 GMT")
    #
    conn
    |> redirect(to: Routes.session_path(conn, :login))

    # end Test
    #

    # conn
    # |> put_resp_content_type("text/plain")
    # |> send_resp(401, body)
  end
end

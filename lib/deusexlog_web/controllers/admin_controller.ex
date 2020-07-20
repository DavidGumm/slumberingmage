defmodule DeusexlogWeb.AdminController do
  use DeusexlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end

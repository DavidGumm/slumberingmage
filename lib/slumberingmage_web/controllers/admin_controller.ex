defmodule SlumberingmageWeb.AdminController do
  use SlumberingmageWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end

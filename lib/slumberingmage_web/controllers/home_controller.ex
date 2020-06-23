defmodule SlumberingmageWeb.HomeController do
  use SlumberingmageWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule SlumberingmageWeb.SessionController do
  use SlumberingmageWeb, :controller

  def new(conn, _params) do
    render(conn, :new, changeset: conn, action: "/login")
  end
end

defmodule SlumberingmageWeb.PageController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{UserManager.User, UserManager, Repo}

  import Ecto.Query

  def index(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    case user do
      nil ->
        conn
          |> put_layout("app.html")
          |> render("index.html")
      user ->
        if true do
          conn
            |> put_layout("user.html")
            |> render("index.html", current_user: user)
        else
          conn
            |> put_layout("admin.html")
            |> render("index.html", current_user: user)
        end
    end
  end

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_user: user)
  end
end

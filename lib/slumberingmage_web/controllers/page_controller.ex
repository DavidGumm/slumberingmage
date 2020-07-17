defmodule SlumberingmageWeb.PageController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{UserManager.User, UserManager, Repo, UserManager.Guardian}

  import Ecto.Query

  def index(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(user))
    |> render("index.html", current_user: user)
  end
end

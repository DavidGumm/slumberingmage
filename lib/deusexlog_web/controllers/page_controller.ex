defmodule DeusexlogWeb.PageController do
  use DeusexlogWeb, :controller

  alias Deusexlog.{UserManager.User, UserManager, Repo, UserManager.Guardian, Posts, Posts.Post}

  import Ecto.Query

  def index(conn, _) do
    posts = Posts.list_latest_posts()
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(user))
    |> render("index.html", current_user: user, posts: posts)
  end
end

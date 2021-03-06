defmodule DeusexlogWeb.ArticleController do
  use DeusexlogWeb, :controller

  alias Deusexlog.{Posts, Posts.Post, Users, Users.User, UserManager.Guardian}

  def index(conn, _params) do
    posts = Posts.list_posts()
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("index.html", posts: posts, current_user: current_user)
  end

  def show(conn, %{"slug" => slug}) do
    Posts.increment_post_view_count(slug)

    post = Posts.get_post_by_slug!(slug)
    user = Users.get_user!(post.user_id)
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("show.html", post: post, user: user, current_user: current_user)
  end
end

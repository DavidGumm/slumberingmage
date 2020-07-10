defmodule SlumberingmageWeb.ArticleController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{Posts, Posts.Post, Users, Users.User}

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get_post_by_slug!(slug)
    user = Users.get_user!(post.user_id)
    render(conn, "show.html", post: post, user: user)
  end
end

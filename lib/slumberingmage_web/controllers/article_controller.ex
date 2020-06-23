defmodule SlumberingmageWeb.ArticleController do
  use SlumberingmageWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias Slumberingmage.Repo
  alias Slumberingmage.CreatePost
  alias Slumberingmage.CreatePost.Post

  def index(conn, _params) do
    query = from p in Post,
      where: p.published == true,
      order_by: [desc: p.date_published],
      limit: 10,
      offset: 0
    posts = Repo.all(query)
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"id" => id}) do
    post = CreatePost.get_post!(id)
    render(conn, "show.html", post: post)
  end

end

defmodule SlumberingmageWeb.PostController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{Posts, Posts.Post, UserManager.Guardian}

  def index(conn, _params) do
    posts = Posts.list_posts()
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("index.html", posts: posts, current_user: current_user)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"post" => post_params}) do
    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(current_user))
        |> render("new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("show.html", post: post, current_user: current_user)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    changeset = Posts.change_post(post)
    users = Slumberingmage.Users.list_users()

    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("edit.html",
      post: post,
      changeset: changeset,
      users: users,
      current_user: current_user
    )
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(current_user))
        |> render("edit.html", post: post, changeset: changeset, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end

defmodule DeusexlogWeb.CommentController do
  use DeusexlogWeb, :controller

  alias Deusexlog.{Comments, Comments.Comment, UserManager.Guardian}

  def index(conn, _params) do
    comments = Comments.list_comments()
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("index.html", comments: comments, current_user: current_user)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Comments.change_comment(%Comment{})
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(current_user))
        |> render("new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("show.html", comment: comment, current_user: current_user)
  end

  def edit(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    changeset = Comments.change_comment(comment)
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("edit.html",
      comment: comment,
      changeset: changeset,
      current_user: current_user
    )
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(current_user))
        |> render("edit.html",
          comment: comment,
          changeset: changeset,
          current_user: current_user
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    {:ok, _comment} = Comments.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end

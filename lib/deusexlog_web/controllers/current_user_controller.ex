defmodule DeusexlogWeb.CurrentUserController do
  use DeusexlogWeb, :controller

  alias Deusexlog.{Users, Users.User, UserManager.Guardian}

  def show(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    user = current_user

    case current_user do
      nil ->
        conn |> redirect(to: Routes.page_path(conn, :index))

      user ->
        conn
        |> put_layout(Guardian.layout(user))
        |> render("show.html",
          user: user,
          current_user: current_user
        )
    end
  end

  def edit(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    user = current_user
    change_user = Users.get_user!(current_user.id)
    changeset = Users.change_user(change_user)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("edit.html", user: user, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(user))
        |> render("edit.html", user: user, changeset: changeset, current_user: current_user)
    end
  end
end

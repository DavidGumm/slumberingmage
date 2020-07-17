defmodule SlumberingmageWeb.UserController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{Users, Users.User, UserManager.Guardian}

  def index(conn, _params) do
    users = Users.list_users()
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("index.html", users: users, current_user: current_user)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    current_user = Guardian.Plug.current_resource(conn)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(current_user))
        |> render("new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)

    case current_user do
      nil ->
        conn |> redirect(to: Routes.page_path(conn, :index))

      user ->
        conn
        |> put_layout(Guardian.layout(user))
        |> render("show.html",
          user: Users.get_user!(current_user.id),
          current_user: current_user
        )
    end
  end

  def show(conn, %{"id" => id}) do
    current_resource = Guardian.Plug.current_resource(conn)

    case current_resource do
      nil ->
        conn |> redirect(to: Routes.page_path(conn, :index))

      user ->
        current_user = Guardian.Plug.current_resource(conn)

        conn
        |> put_layout(Guardian.layout(current_user))
        |> render("show.html", user: Users.get_user!(id), current_user: current_user)
    end
  end

  def edit(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    user = Users.get_user!(current_user.id)
    changeset = Users.change_user(user)

    conn
    |> put_layout(Guardian.layout(current_user))
    |> render("edit.html", user: user, changeset: changeset, current_user: current_user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    current_user = Guardian.Plug.current_resource(conn)

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

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end

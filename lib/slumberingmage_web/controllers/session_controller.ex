defmodule SlumberingmageWeb.SessionController do
  use SlumberingmageWeb, :controller
  require Logger
  alias Slumberingmage.{UserManager, UserManager.User, UserManager.Guardian}

  def new(conn, _) do
    changeset = UserManager.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      redirect(conn, to: "/account")
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    auth = UserManager.authenticate_user(username, password)
    auth |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out() #This module's full name is Auth.UserManager.Guardian.Plug,
    |> redirect(to: "/login")   #and the arguments specfied in the Guardian.Plug.sign_out()
  end                           #docs are not applicable here

  defp login_reply({:ok, user}, conn) do
    Guardian.Plug.sign_in(conn, user)
    |> put_flash(:info, "Welcome back #{user.username}.")
    |> redirect(to: "/account")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
defmodule SlumberingmageWeb.AccountController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{Accounts, Accounts.Account, UserManager.Guardian}

  def show(conn, _params) do
    if Guardian.Plug.authenticated?(conn) do
      user = Guardian.Plug.current_resource(conn)
      render(conn, "show.html", current_user: user)
    else
      conn |> redirect(to: Routes.session_path(conn, :login))
    end
  end

  def edit(conn, _params) do
    if Guardian.Plug.authenticated?(conn) do
      user = Guardian.Plug.current_resource(conn)
      changeset = Slumberingmage.UserManager.change_user(user)
      render(conn, "edit.html", current_user: user, changeset: changeset)
    else
      conn |> redirect(to: Routes.session_path(conn, :login))
    end
  end
end

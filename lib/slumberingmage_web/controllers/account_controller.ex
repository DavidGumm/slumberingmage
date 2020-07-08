defmodule SlumberingmageWeb.AccountController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{Accounts, Accounts.Account, UserManager.Guardian}

  def show(conn) do
    render(conn, "show.html", user: Guardian.call(conn))
  end

  def edit(conn) do
    user = Guardian.call(conn)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end
end

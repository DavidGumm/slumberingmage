defmodule SlumberingmageWeb.AccountController do
  use SlumberingmageWeb, :controller

  alias Slumberingmage.{Accounts, Accounts.Account, UserManager.Guardian, Users, Users.User}
  require Logger

  def show(conn, _params) do
    if Guardian.Plug.authenticated?(conn) do
      current_resource = Guardian.Plug.current_resource(conn)
      log(current_resource)

      user = Users.get_user!(current_resource.id)
      render(conn, "show.html", user: user)
    else
      conn |> redirect(to: Routes.session_path(conn, :login))
    end
  end

  def edit(conn, _params) do
    if Guardian.Plug.authenticated?(conn) do
      current_resource = Guardian.Plug.current_resource(conn)
      user = Users.get_user!(current_resource.id)
      changeset = Users.change_user(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    else
      conn |> redirect(to: Routes.session_path(conn, :login))
    end
  end

  defp log(items) do
    Enum.each(items, fn item -> Logger.debug("#{item}") end)
    # Enum.for item <- items do
    # end
  end
end

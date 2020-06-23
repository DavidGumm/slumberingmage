defmodule SlumberingmageWeb.RegistrationController do
  use SlumberingmageWeb, :controller

  alias SlumberingmageWeb.Authentication

  def new(conn, _) do
    render(conn, :new, changeset: conn, action: "/register")
  end

  #Slumberingmage.CreateUser.create_user()

  def create(conn, %{"user" => user_params}) do
    case Users.register(user_params) do
      {:ok, account} ->
        conn
        |> Authentication.log_in(account)
        |> redirect(to: Routes.profile_path(conn, :show))

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end
end

defmodule DeusexlogWeb.RegistrationController do
  use DeusexlogWeb, :controller

  plug Ueberauth
  alias Deusexlog.Users
  alias DeusexlogWeb.Authentication

  def new(conn, _) do
    render(conn, :new, changeset: conn, action: "/register")
  end

  def create(conn, %{"account" => account_params}) do
    case Accounts.register(account_params) do
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

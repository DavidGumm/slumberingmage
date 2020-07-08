defmodule Slumberingmage.UserManager.Guardian do
  use Guardian, otp_app: :slumberingmage

  alias Slumberingmage.UserManager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = UserManager.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end



    def call(conn, _opts) do
     current_token = Guardian.Plug.current_token(conn)
      case MyApp.Guardian.resource_from_token(current_token) do
        {:ok, user, claims} ->
              Plug.Conn.assign(conn, :current_user, user)
        {:error, _reason} ->
          conn
      end
    end


end

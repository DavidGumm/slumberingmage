defmodule Deusexlog.UserManager.Guardian do
  use Guardian, otp_app: :deusexlog

  alias Deusexlog.UserManager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = UserManager.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def layout(user) do
    case user do
      nil ->
        "app.html"

      user ->
        case user.access do
          "user" ->
            "user.html"

          "admin" ->
            "admin.html"

          nil ->
            "admin.html"

          "" ->
            "app.html"
        end
    end
  end
end

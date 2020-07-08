defmodule Slumberingmage.Accounts do
  import Ecto.Query, warn: false
  alias Slumberingmage.Repo

  alias Slumberingmage.Users.User

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end

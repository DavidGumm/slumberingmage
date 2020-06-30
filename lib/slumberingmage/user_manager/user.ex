defmodule Slumberingmage.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin

  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    #change(changeset, password: Comeonin.add_hash(password))
    change(changeset, password: password)
  end

  defp put_password_hash(changeset), do: changeset
end

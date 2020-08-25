defmodule Deusexlog.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  require Logger

  schema "users" do
    field :password, :string
    field :username, :string
    field :email, :string
    field :access, :string
    field :image, :string
    field :bio, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email, :access, :image, :bio])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end

defmodule Slumberingmage.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string
    field :username, :string
    field :email, :string
    field :access, :string
    field :image, :string
    field :bio, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email, :access, :image, :bio])
    |> validate_required([:username, :password, :email, :access, :image, :bio])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end

defmodule Slumberingmage.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :access, :string
    field :bio, :string
    field :email, :string
    field :image, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :access, :image, :bio])
    |> validate_required([:username, :email, :access, :image, :bio])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end

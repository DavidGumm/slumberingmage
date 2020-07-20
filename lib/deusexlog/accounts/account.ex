defmodule Deusexlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :string
    field :email, :string
    field :image, :string
    field :username, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :image, :bio, :password])
    |> validate_required([:username, :email, :image, :bio, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end

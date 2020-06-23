defmodule Slumberingmage.CreateUser.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :password, Slumberingmage.Encrypted.Binary

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :password])
    |> validate_required([:name, :username, :email, :password])
  end

end

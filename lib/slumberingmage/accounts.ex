defmodule Slumberingmage.Accounts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :password, Slumberingmage.Encrypted.Binary
    field :encrypted_password, Cloak.Ecto.SHA256

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :username, :email, :password])
    |> validate_required([:name, :username, :email, :password])
    |> validate_confirmation(:password, required: true)
    |> unique_constraint([:email, :username])
    |> put_hashed_fields()
  end

  defp put_hashed_fields(changeset) do
    put_change(changeset, :email_hash, get_field(changeset, :email))
  end

  def get_account(id) do
    Slumberingmage.Repo.get(User, id)
  end
end

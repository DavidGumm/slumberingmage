defmodule Slumberingmage.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :binary

      timestamps()
    end

  end
end

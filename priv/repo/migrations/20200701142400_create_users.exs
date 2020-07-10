defmodule Slumberingmage.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :email, :string
      add :access, {:array, :string}, null: true
      add :image, :string
      add :bio, :text

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end

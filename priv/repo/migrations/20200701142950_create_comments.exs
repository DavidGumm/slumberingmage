defmodule Slumberingmage.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :author, :string
      add :date, :naive_datetime
      add :comments, :text
      add :avatar, :string
      add :post_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end

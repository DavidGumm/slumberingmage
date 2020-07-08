defmodule Slumberingmage.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :tag, :string
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:tags, [:post_id])
  end
end

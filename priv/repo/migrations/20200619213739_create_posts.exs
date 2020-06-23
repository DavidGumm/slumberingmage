defmodule Slumberingmage.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :tags, {:array, :string}
      add :content, :text
      add :excerpt, :text
      add :date_published, :date
      add :user_id, references(:users)
      add :published, :boolean, default: false, null: false

      timestamps()

    end
    create unique_index(:posts, [:slug], concurrently: true) do
    end
    end
  end
end

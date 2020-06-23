defmodule Slumberingmage.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string, size: 100
      add :tags, {:array, :string}
      add :content, :text
      add :excerpt, :text
      add :date_published, :date
      add :user_id, references(:users)
      add :published, :boolean, default: false, null: false

      timestamps()

    end

    create unique_index(:posts, [:slug], name: :post_slug_unique)

    end
  end

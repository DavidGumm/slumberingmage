defmodule Slumberingmage.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :slug, :string
      add :title, :string
      add :body, :text
      add :published, :boolean, default: false, null: false
      add :cover, :string
      add :tags, {:array, :string}, null: true
      add :views, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:posts, [:slug])
    create unique_index(:posts, [:title])
    create index(:posts, [:user_id])
  end
end

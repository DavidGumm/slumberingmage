defmodule Slumberingmage.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :cover, :string, default: ""
    field :tags, {:array, :string}
    field :published, :boolean, default: false
    field :slug, :string
    field :title, :string
    field :views, :integer, default: 0
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:slug, :title, :body, :published, :cover, :views, :tags])
    |> validate_required([:slug, :title, :body, :published, :cover, :views, :tags])
    |> unique_constraint(:slug)
    |> unique_constraint(:title)
  end
end

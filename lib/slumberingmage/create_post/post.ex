defmodule Slumberingmage.CreatePost.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :date_published, :date
    field :excerpt, :string
    field :published, :boolean, default: false
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :url, :content, :excerpt, :date_published, :published])
    |> validate_required([:title, :url, :content, :excerpt, :published])
  end
end

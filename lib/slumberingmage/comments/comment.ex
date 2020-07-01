defmodule Slumberingmage.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :author, :string
    field :avatar, :string
    field :comments, :string
    field :date, :naive_datetime
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author, :date, :comments, :avatar])
    |> validate_required([:author, :date, :comments, :avatar])
  end
end

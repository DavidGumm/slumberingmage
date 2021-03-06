defmodule Deusexlog.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Deusexlog.Repo

  alias Deusexlog.Posts.Post

  @doc """
  Returns the list of posts and views.

  ## Examples

      iex> aggregate_post_views()
      [%Post{}, ...]

  """
  def aggregate_post_views do
    Repo.aggregate(Post, :count, :views)
  end

  @doc """
  Returns an aggregate of posts and tags.

  ## Examples

      iex> aggregate_tags()
      [%Post{}, ...]

  """
  def aggregate_tags do
    Repo.aggregate(Post, :count, :tags)
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Returns the list of 5 latest posts.

  ## Examples

      iex> list_latest_posts()
      [%Post{}, ...]

  """
  def list_latest_posts do
    now = DateTime.utc_now()
    query = Post |> where([p], p.published == true and p.publish_date <= ^now) |> limit(5)

    # query = from p in Post, where: p.published == true, limit(5)
    Enum.reverse(Repo.all(query))
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_by_slug!(slug_name), do: Repo.get_by!(Post, slug: slug_name)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post!(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> increment_post_view_count(id)
      {:ok, %Post{}}

      iex> increment_post_view_count(id)
      {:error, %Ecto.Changeset{}}

  """
  def increment_post_view_count(slug_name) do
    post = Repo.get_by!(Post, slug: slug_name)

    post
    |> Post.changeset(%{views: post.views + 1})
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end

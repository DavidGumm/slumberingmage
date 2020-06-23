defmodule Slumberingmage.CreatePostTest do
  use Slumberingmage.DataCase

  alias Slumberingmage.CreatePost

  describe "posts" do
    alias Slumberingmage.CreatePost.Post

    @valid_attrs %{content: "some content", date_published: ~D[2010-04-17], excerpt: "some excerpt", published: true, title: "some title", url: "some url"}
    @update_attrs %{content: "some updated content", date_published: ~D[2011-05-18], excerpt: "some updated excerpt", published: false, title: "some updated title", url: "some updated url"}
    @invalid_attrs %{content: nil, date_published: nil, excerpt: nil, published: nil, title: nil, url: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CreatePost.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert CreatePost.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert CreatePost.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = CreatePost.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.date_published == ~D[2010-04-17]
      assert post.excerpt == "some excerpt"
      assert post.published == true
      assert post.title == "some title"
      assert post.url == "some url"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CreatePost.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = CreatePost.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.date_published == ~D[2011-05-18]
      assert post.excerpt == "some updated excerpt"
      assert post.published == false
      assert post.title == "some updated title"
      assert post.url == "some updated url"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = CreatePost.update_post(post, @invalid_attrs)
      assert post == CreatePost.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = CreatePost.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> CreatePost.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = CreatePost.change_post(post)
    end
  end
end

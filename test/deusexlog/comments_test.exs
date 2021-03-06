defmodule Deusexlog.CommentsTest do
  use Deusexlog.DataCase

  alias Deusexlog.Comments

  describe "comments" do
    alias Deusexlog.Comments.Comment

    @valid_attrs %{author: "some author", avatar: "some avatar", comments: "some comments", date: ~N[2010-04-17 14:00:00]}
    @update_attrs %{author: "some updated author", avatar: "some updated avatar", comments: "some updated comments", date: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{author: nil, avatar: nil, comments: nil, date: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comments.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Comments.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Comments.create_comment(@valid_attrs)
      assert comment.author == "some author"
      assert comment.avatar == "some avatar"
      assert comment.comments == "some comments"
      assert comment.date == ~N[2010-04-17 14:00:00]
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, @update_attrs)
      assert comment.author == "some updated author"
      assert comment.avatar == "some updated avatar"
      assert comment.comments == "some updated comments"
      assert comment.date == ~N[2011-05-18 15:01:01]
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end

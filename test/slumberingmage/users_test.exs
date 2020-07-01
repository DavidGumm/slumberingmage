defmodule Slumberingmage.UsersTest do
  use Slumberingmage.DataCase

  alias Slumberingmage.Users

  describe "users" do
    alias Slumberingmage.Users.User

    @valid_attrs %{access: "some access", bio: "some bio", email: "some email", image: "some image", username: "some username"}
    @update_attrs %{access: "some updated access", bio: "some updated bio", email: "some updated email", image: "some updated image", username: "some updated username"}
    @invalid_attrs %{access: nil, bio: nil, email: nil, image: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.access == "some access"
      assert user.bio == "some bio"
      assert user.email == "some email"
      assert user.image == "some image"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.access == "some updated access"
      assert user.bio == "some updated bio"
      assert user.email == "some updated email"
      assert user.image == "some updated image"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end

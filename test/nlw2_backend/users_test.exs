defmodule Nlw2Backend.UsersTest do
  use Nlw2Backend.DataCase

  alias Nlw2Backend.Users

  describe "users" do
    alias Nlw2Backend.Users.User

    @valid_attrs %{avatar: "some avatar", bio: "some bio", name: "some name", whatsapp: "some whatsapp"}
    @update_attrs %{avatar: "some updated avatar", bio: "some updated bio", name: "some updated name", whatsapp: "some updated whatsapp"}
    @invalid_attrs %{avatar: nil, bio: nil, name: nil, whatsapp: nil}

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
      assert user.avatar == "some avatar"
      assert user.bio == "some bio"
      assert user.name == "some name"
      assert user.whatsapp == "some whatsapp"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.bio == "some updated bio"
      assert user.name == "some updated name"
      assert user.whatsapp == "some updated whatsapp"
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

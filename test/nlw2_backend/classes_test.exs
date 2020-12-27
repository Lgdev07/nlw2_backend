defmodule Nlw2Backend.ClassesTest do
  use Nlw2Backend.DataCase

  alias Nlw2Backend.Classes

  describe "classes" do
    alias Nlw2Backend.Classes.Class

    @valid_attrs %{cost: "120.5", subject: "some subject"}
    @update_attrs %{cost: "456.7", subject: "some updated subject"}
    @invalid_attrs %{cost: nil, subject: nil}

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Classes.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert Classes.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert Classes.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = Classes.create_class(@valid_attrs)
      assert class.cost == Decimal.new("120.5")
      assert class.subject == "some subject"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classes.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, %Class{} = class} = Classes.update_class(class, @update_attrs)
      assert class.cost == Decimal.new("456.7")
      assert class.subject == "some updated subject"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Classes.update_class(class, @invalid_attrs)
      assert class == Classes.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = Classes.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = Classes.change_class(class)
    end
  end
end

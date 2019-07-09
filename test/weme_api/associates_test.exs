defmodule WeMeApi.AssociatesTest do
  use WeMeApi.DataCase

  alias WeMeApi.Associates

  describe "users" do
    alias WeMeApi.Associates.User

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Associates.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Associates.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Associates.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Associates.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Associates.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Associates.update_user(user, @update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Associates.update_user(user, @invalid_attrs)
      assert user == Associates.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Associates.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Associates.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Associates.change_user(user)
    end
  end

  describe "connections" do
    alias WeMeApi.Associates.Connection

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def connection_fixture(attrs \\ %{}) do
      {:ok, connection} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Associates.create_connection()

      connection
    end

    test "list_connections/0 returns all connections" do
      connection = connection_fixture()
      assert Associates.list_connections() == [connection]
    end

    test "get_connection!/1 returns the connection with given id" do
      connection = connection_fixture()
      assert Associates.get_connection!(connection.id) == connection
    end

    test "create_connection/1 with valid data creates a connection" do
      assert {:ok, %Connection{} = connection} = Associates.create_connection(@valid_attrs)
    end

    test "create_connection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Associates.create_connection(@invalid_attrs)
    end

    test "update_connection/2 with valid data updates the connection" do
      connection = connection_fixture()
      assert {:ok, %Connection{} = connection} = Associates.update_connection(connection, @update_attrs)
    end

    test "update_connection/2 with invalid data returns error changeset" do
      connection = connection_fixture()
      assert {:error, %Ecto.Changeset{}} = Associates.update_connection(connection, @invalid_attrs)
      assert connection == Associates.get_connection!(connection.id)
    end

    test "delete_connection/1 deletes the connection" do
      connection = connection_fixture()
      assert {:ok, %Connection{}} = Associates.delete_connection(connection)
      assert_raise Ecto.NoResultsError, fn -> Associates.get_connection!(connection.id) end
    end

    test "change_connection/1 returns a connection changeset" do
      connection = connection_fixture()
      assert %Ecto.Changeset{} = Associates.change_connection(connection)
    end
  end

  describe "links" do
    alias WeMeApi.Associates.Link

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Associates.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Associates.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Associates.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Associates.create_link(@valid_attrs)
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Associates.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = Associates.update_link(link, @update_attrs)
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Associates.update_link(link, @invalid_attrs)
      assert link == Associates.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Associates.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Associates.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Associates.change_link(link)
    end
  end
end

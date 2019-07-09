defmodule WeMeApi.UserTest do
  use WeMeApi.DataCase

  describe "users" do
    alias WeMeApi.Users
    @valid_attrs %{}
    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = WeMeApi.create_user(@valid_attrs)
    end

    IO.puts("THIS IS A TEST")
  end
end

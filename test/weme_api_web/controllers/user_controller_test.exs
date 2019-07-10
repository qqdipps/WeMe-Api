defmodule WeMeApiWeb.UserControllerTest do
  use WeMeApiWeb.ConnCase
  import Ecto.Query

  alias WeMeApi.Associates
  alias WeMeApi.Repo
  alias Associates.User

  @create_attrs %{}
  @update_attrs %{}

  def fixture(:user) do
    {:ok, user} = Associates.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      last_user_record = from(d in User, limit: 1, order_by: [desc: d.inserted_at]) |> Repo.one()

      assert %{
               "id" => id
             } = %{"id" => last_user_record.id}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      user_to_delete =
        from(u in User, where: u.id == ^user.id)
        |> Repo.one()

      assert user_to_delete == user
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      user_deleted? =
        nil ==
          from(u in User, where: u.id == ^user.id)
          |> Repo.one()

      assert user_deleted? == true
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end

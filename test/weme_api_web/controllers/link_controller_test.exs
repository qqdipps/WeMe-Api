defmodule WeMeApiWeb.LinkControllerTest do
  use WeMeApiWeb.ConnCase

  alias WeMeApi.Associates
  alias WeMeApi.Associates.Link

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{user_id: -1, connection_id: -2}

  def user_fixture() do
    {:ok, user} = Associates.create_user()
    user
  end

  def connection_fixture() do
    {:ok, connection} = Associates.create_connection()
    connection
  end

  def fixture(:link) do
    {:ok, link} =
      Associates.create_link(%{user_id: user_fixture.id, connection_id: connection_fixture.id})

    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.link_path(conn, :create),
          link: %{user_id: user_fixture.id, connection_id: connection_fixture.id}
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]
      conn = get(conn, Routes.link_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @invalid_attrs)
      assert json_response(conn, 400)["errors"] == %{"detail" => "Bad Request"}
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete(conn, Routes.link_path(conn, :delete, link))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.link_path(conn, :show, link))
      end)
    end
  end

  defp create_link(_) do
    link = fixture(:link)
    {:ok, link: link}
  end
end

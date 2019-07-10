defmodule WeMeApiWeb.ConnectionControllerTest do
  use WeMeApiWeb.ConnCase

  alias WeMeApi.Associates
  alias WeMeApi.Associates.Connection

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:connection) do
    {:ok, connection} = Associates.create_connection(@create_attrs)
    connection
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all connections", %{conn: conn} do
      conn = get(conn, Routes.connection_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create connection" do
    test "renders connection when data is valid", %{conn: conn} do
      conn = post(conn, Routes.connection_path(conn, :create), connection: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.connection_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update connection" do
    setup [:create_connection]

    test "renders connection when data is valid", %{
      conn: conn,
      connection: %Connection{id: id} = connection
    } do
      conn =
        put(conn, Routes.connection_path(conn, :update, connection), connection: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.connection_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete connection" do
    setup [:create_connection]

    test "deletes chosen connection", %{conn: conn, connection: connection} do
      conn = delete(conn, Routes.connection_path(conn, :delete, connection))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.connection_path(conn, :show, connection))
      end)
    end
  end

  defp create_connection(_) do
    connection = fixture(:connection)
    {:ok, connection: connection}
  end
end

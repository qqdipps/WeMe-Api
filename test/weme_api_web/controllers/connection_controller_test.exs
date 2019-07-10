defmodule WeMeApiWeb.ConnectionControllerTest do
  use WeMeApiWeb.ConnCase
  import Ecto.Query

  alias WeMeApi.Associates
  alias Associates.Connection
  alias WeMeApi.Repo

  @create_attrs %{}

  def fixture(:connection) do
    {:ok, connection} = Associates.create_connection(@create_attrs)
    connection
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create connection" do
    test "renders connection when data is valid", %{conn: conn} do
      conn = post(conn, Routes.connection_path(conn, :create), connection: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      last_connection_record =
        from(c in Connection, limit: 1, order_by: [desc: c.inserted_at]) |> Repo.one()

      assert %{
               "id" => id
             } = %{"id" => last_connection_record.id}
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

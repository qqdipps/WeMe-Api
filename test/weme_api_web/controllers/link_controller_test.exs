defmodule WeMeApiWeb.LinkControllerTest do
  use WeMeApiWeb.ConnCase
  import Ecto.Query

  alias WeMeApi.Associates
  alias Associates.Link
  alias WeMeApi.Repo

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
      Associates.create_link(%{user_id: user_fixture().id, connection_id: connection_fixture().id})

    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.link_path(conn, :create),
          link: %{user_id: user_fixture().id, connection_id: connection_fixture().id}
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      last_link_record = from(l in Link, limit: 1, order_by: [desc: l.inserted_at]) |> Repo.one()

      assert %{
               "id" => id
             } = %{"id" => last_link_record.id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @invalid_attrs)
      assert json_response(conn, 400)["errors"] == %{"detail" => "Bad Request"}
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      link_to_delete =
        from(l in Link, where: l.id == ^link.id)
        |> Repo.one()

      assert link_to_delete == link
      conn = delete(conn, Routes.link_path(conn, :delete, link))
      assert response(conn, 204)

      link_deleted? =
        nil ==
          from(l in Link, where: l.id == ^link.id)
          |> Repo.one()

      assert link_deleted? == true
    end
  end

  defp create_link(_) do
    link = fixture(:link)
    {:ok, link: link}
  end
end

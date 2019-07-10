defmodule WeMeApiWeb.ConnectionController do
  use WeMeApiWeb, :controller

  alias WeMeApi.Associates
  alias WeMeApi.Associates.Connection

  action_fallback WeMeApiWeb.FallbackController

  def index(conn, _params) do
    connections = Associates.list_connections()
    render(conn, "index.json", connections: connections)
  end

  def create(conn, %{"connection" => connection_params}) do
    with {:ok, %Connection{} = connection} <- Associates.create_connection(connection_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.connection_path(conn, :show, connection))
      |> render("show.json", connection: connection)
    end
  end

  def show(conn, %{"id" => id}) do
    connection = Associates.get_connection!(id)
    render(conn, "show.json", connection: connection)
  end

  def update(conn, %{"id" => id, "connection" => connection_params}) do
    connection = Associates.get_connection!(id)

    with {:ok, %Connection{} = connection} <- Associates.update_connection(connection, connection_params) do
      render(conn, "show.json", connection: connection)
    end
  end

  def delete(conn, %{"id" => id}) do
    connection = Associates.get_connection!(id)

    with {:ok, %Connection{}} <- Associates.delete_connection(connection) do
      send_resp(conn, :no_content, "")
    end
  end
end

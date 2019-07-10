defmodule WeMeApiWeb.ConnectionController do
  use WeMeApiWeb, :controller

  alias WeMeApi.Associates
  alias WeMeApi.Associates.Connection

  action_fallback(WeMeApiWeb.FallbackController)

  def create(conn, %{"connection" => connection_params}) do
    with {:ok, %Connection{} = connection} <- Associates.create_connection(connection_params) do
      conn
      |> put_status(:created)
      |> render("show.json", connection: connection)
    end
  end

  def delete(conn, %{"id" => id}) do
    connection = Associates.get_connection!(id)

    with {:ok, %Connection{}} <- Associates.delete_connection(connection) do
      send_resp(conn, :no_content, "")
    end
  end
end

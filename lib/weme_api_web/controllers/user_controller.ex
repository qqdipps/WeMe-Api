defmodule WeMeApiWeb.UserController do
  use WeMeApiWeb, :controller

  alias WeMeApi.Associates
  alias WeMeApi.Associates.User

  action_fallback(WeMeApiWeb.FallbackController)

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Associates.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Associates.get_user!(id)

    with {:ok, %User{}} <- Associates.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule WeMeApiWeb.UserController do
  use WeMeApiWeb, :controller

  alias WeMeApi.Associates
  alias WeMeApi.Associates.User

  action_fallback WeMeApiWeb.FallbackController

  def index(conn, _params) do
    users = Associates.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Associates.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Associates.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Associates.get_user!(id)

    with {:ok, %User{} = user} <- Associates.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Associates.get_user!(id)

    with {:ok, %User{}} <- Associates.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

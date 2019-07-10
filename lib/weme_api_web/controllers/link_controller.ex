defmodule WeMeApiWeb.LinkController do
  use WeMeApiWeb, :controller

  alias WeMeApi.Associates
  alias WeMeApi.Associates.Link

  action_fallback(WeMeApiWeb.FallbackController)

  def create(conn, %{"link" => link_params}) do
    new_link = Associates.create_link(link_params)

    with {:ok, %Link{} = link} <- Associates.create_link(link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Associates.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def delete(conn, %{"id" => id}) do
    link = Associates.get_link!(id)

    with {:ok, %Link{}} <- Associates.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end
end

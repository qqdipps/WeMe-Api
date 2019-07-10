defmodule WeMeApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use WeMeApiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(WeMeApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, _whatever}) do
    conn
    |> put_status(:bad_request)
    |> put_view(WeMeApiWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, _whatever) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(WeMeApiWeb.ErrorView)
    |> render(:"500")
  end
end

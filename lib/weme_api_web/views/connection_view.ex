defmodule WeMeApiWeb.ConnectionView do
  use WeMeApiWeb, :view
  alias WeMeApiWeb.ConnectionView

  def render("index.json", %{connections: connections}) do
    %{data: render_many(connections, ConnectionView, "connection.json")}
  end

  def render("show.json", %{connection: connection}) do
    %{data: render_one(connection, ConnectionView, "connection.json")}
  end

  def render("connection.json", %{connection: connection}) do
    %{id: connection.id}
  end
end

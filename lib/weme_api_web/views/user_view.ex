defmodule WeMeApiWeb.UserView do
  use WeMeApiWeb, :view
  alias WeMeApiWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("setup.json", %{user: user, connection: connection, link: link}) do
    %{data: %{user_id: user.id, connection_id: connection.id, link_id: link.id}}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id}
  end
end

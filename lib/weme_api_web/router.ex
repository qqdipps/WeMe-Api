defmodule WeMeApiWeb.Router do
  use WeMeApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WeMeApiWeb do
    pipe_through :api
  end
end

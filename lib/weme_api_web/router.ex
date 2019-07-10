defmodule WeMeApiWeb.Router do
  use WeMeApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", WeMeApiWeb do
    pipe_through(:api)
    resources("/users", UserController, only: [:create, :delete])
    resources("/connections", ConnectionController, only: [:create, :delete])
    resources("/links", LinkController, except: [:new, :edit])
  end
end

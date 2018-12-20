defmodule ImageApiWeb.Router do
  use ImageApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ImageApiWeb do
    pipe_through :api

    post "/images/actions/validate", ImageController, :validate
    post "/images/actions/resize", ImageController, :resize
  end
end

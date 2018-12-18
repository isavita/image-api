defmodule ImageApiWeb.Router do
  use ImageApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ImageApiWeb do
    pipe_through :api
  end
end

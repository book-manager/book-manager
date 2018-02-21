defmodule BookerWeb.Router do
  use BookerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BookerWeb do
    pipe_through :api
  end
end

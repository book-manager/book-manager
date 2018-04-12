defmodule BookerWeb.Router do
  use BookerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Booker.Auth.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", BookerWeb do
    pipe_through :api
  end

  pipeline :admin do
    plug Booker.Auth.AdminPlug
  end

  scope "/", BookerWeb do
    pipe_through [:api]
    post "/login", UserController, :login
    post "/register", UserController, :register
  end

  scope "/auth", BookerWeb do
    pipe_through :api
    post "/", UserController, :check_auth
  end

  scope "/users", BookerWeb do
    pipe_through [:api, :admin]

    get "/", UserController, :index
  end
end

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
    pipe_through [:api, :auth]

    scope "/authors" do
      post "/", AuthorsController, :create
      get "/", AuthorsController, :index
      get "/:id", AuthorsController, :show
      get "/search/:query", AuthorsController, :search
      get "/owned/:id", AuthorsController, :owned
      post "/ownership", AuthorsController, :create_ownership
      get "/books/:id", AuthorsController, :books
    end

    scope "/books" do
      post "/", BookController, :create
      get "/:id", BookController, :show
      get "/owned/:id", BookController, :owned
    end

    scope "/friends" do
      post "/search", UserController, :search_user
      get "/", FriendshipController, :index
    end

    scope "/users" do
      get "/", UserController, :index
      get "/:id", UserController, :show
    end

    scope "/friendship" do
      post "/", FriendshipController, :create
      post "/check-friendship", FriendshipController, :check_friendship
      get "/pending", FriendshipController, :pending_requests
      # get "/", UserController, :fetch_users_detail
      # post "/search", UserController, :search_user
    end
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
end

defmodule AuthWrapper do
  @moduledoc """
  We need to wrap this in module to avoid Phoenix error about double forward to the same module
  """
  use Plug.Builder

  plug Absinthe.Plug, schema: Booker.Auth.Schema
end

defmodule AuthGraphiWrapper do
  @moduledoc """
  We need to wrap this in module to avoid Phoenix error about double forward to the same module
  """
  use Plug.Builder

  plug Absinthe.Plug.GraphiQL,  schema: Booker.Auth.Schema
end

defmodule BookerWeb.Router do
  use BookerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Booker.Auth.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :graphql do
    plug BookerWeb.Context
  end

  forward "/graphiql/auth", AuthGraphiWrapper
  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: BookerWeb.Schema

  scope "/graph" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: BookerWeb.Schema
  end

  forward "/auth", AuthWrapper

  # scope "/", BookerWeb do
  #   post "/login", UserController, :login
  #   post "/register", UserController, :register
  # end

  scope "/api", BookerWeb do
    pipe_through [:api, :auth]

    scope "/authors" do
      post "/", AuthorController, :create
      get "/", AuthorController, :index
      get "/:id", AuthorController, :show
      get "/search/:query", AuthorController, :search
      get "/owned/:id", AuthorController, :owned
      get "/books/:id", AuthorController, :books
    end

    scope "/books" do
      post "/", BookController, :create
      get "/", BookController, :index
      get "/:id", BookController, :show
      get "/owned/:id", BookController, :owned
      post "/ownership", BookController, :create_ownership
      # get "/rating/:id", BookController, :show_rating
    end

    scope "/ownership" do
      get "/:id", OwnershipController, :show
      post "/", OwnershipController, :create
    end

    scope "/books_ownership" do
      post "/read", BookOwnershipController, :update
    end

    scope "/friends" do
      get "/search/:query", UserController, :search_user
      get "/", FriendshipController, :index
      get "/book/:id", UserController, :show_friends_book
    end

    scope "/users" do
      get "/", UserController, :index
      get "/:id", UserController, :show
    end

    scope "/friendship" do
      post "/", FriendshipController, :create
      get "/check-friendship/:id", FriendshipController, :check_friendship
      get "/check-incoming/:id", FriendshipController, :check_friendship_incoming
      get "/pending", FriendshipController, :pending_requests
      get "/accept/:id", FriendshipController, :accept
    end
  end

  pipeline :admin do
    plug Booker.Auth.AdminPlug
  end

end

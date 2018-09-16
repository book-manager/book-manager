require IEx
require Logger
defmodule BookerWeb.UserController do
  use BookerWeb, :controller

  alias Booker.Auth
  alias Booker.Auth.{Friendship, Guardian, User}
  alias Booker.Books.BookOwnership
  alias Booker.Repo

  alias Ecto.Changeset

  import Ecto.Query

  action_fallback BookerWeb.FallbackController

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  @spec login(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def login(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        login_reply(conn, user)
      {:error, _} ->
        conn
        |> put_status(401)
    end
  end

  defp login_reply(conn, user) do
    {:ok, token, _} = Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {1, :days})
    render(conn, "token.json", %{token: token, user: user})
  end

  @doc """
  Search for users based on provided query. It can be name or surname or name and surname. We replace spaces with | so full text search in Postgres.

  Returns [User]
  """
  def search_user(conn, %{"query" => query}) do
    formatted = query |> String.replace(" ", "|")
    users = Repo.execute_and_load("SELECT * FROM users WHERE id IN (SELECT searchable_id FROM searches WHERE to_tsvector('english', term) @@ to_tsquery($1));", [ formatted ], User)

    render(conn, "index.json", users: users)
  end

  @spec register(any(), map()) :: any()
  def register(conn, %{"email" => email, "name" => name, "surname"=> surname, "password" => password, "cpassword" => re_password}) do
     case password == re_password do
      true ->
        case Auth.create_user(%{ "email" => email, "name" => name, "surname"=> surname, "password" => password }) do
          {:ok, user} ->
            conn
              |> put_status(:created)
              |> render("user.json", user: user)
          {:error, %Changeset{errors: [email: {"email is already taken", []}]}} ->
            conn
              |> put_status(409)
        end
      false ->
        conn |> put_status(422)
     end
  end

  # TODO: Handle errors
  @spec check_auth(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def check_auth(conn, %{"token" => token}) do
    case Guardian.resource_from_token(token) do
      {:ok, %Booker.Auth.User{} = user, _} ->
        render(conn, "token.json", token: token, user: user )
      {:error, _, _} ->
        conn |> halt
    end
  end

  @spec create(any(), map()) :: any()
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
        |> put_status(:created)
        |> render("show.json", user: user)
    end
  end

   @doc """
  Return friends that own given book

  Returns [Friends]
  """
  def show_friends_book(conn, %{"id" => book_id}) do
    query =
      from(o in BookOwnership,
        join: u in User,
        on: u.id == o.user_id,
        join: f in Friendship,
        on: f.friend_b_id == u.id,
        where: o.book_id == ^book_id,
        select: u
      )

    friends = query |> Repo.all()
    Logger.info("Users that have given book and are my friends: #{inspect friends}")
    conn |> render("index.json", users: friends)
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    case Auth.get_user(id) do
      nil ->
        conn |> put_status(404)
      %User{} = user ->
        render(conn, "user.json", user: user)
    end
  end
end

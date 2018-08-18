require Logger
defmodule BookerWeb.UserController do
  use BookerWeb, :controller

  alias Booker.Auth
  alias Booker.Auth.Guardian
  alias Booker.Auth.User
  alias Booker.Repo

  import Ecto.Query

  action_fallback BookerWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    Auth.authenticate_user(email, password)
      |> login_reply(conn)
  end

  @doc """
  Creates encoded token with current user, without any custom claims, token_type is access and TTL is 1 day.

  Returns %{token: created_token, user: current_user}
  """
  defp login_reply({:ok, user}, conn) do
    {:ok, token, _} = Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {1, :days})
    render conn, "token.json", token: token, user: user
  end

  @doc """
  Search for users based on provided query. It can be name or surname or name and surname. We replace spaces with | so full text search in Postgres.

  Returns [User]
  """
  def search_user(conn, %{"query" => query}) do
    formatted = query |> String.replace(" ", "|")
    users = Repo.execute_and_load("SELECT * FROM users WHERE id IN (SELECT searchable_id FROM searches WHERE to_tsvector('english', term) @@ to_tsquery($1));", [ formatted ], User)
    conn
      |> put_status(:ok)
      |> render("index.json", users: users)
  end


  @doc """
  Fetch details about users with given ids.

  Returns [User]
  """
  def fetch_users_detail(conn, params) do
    ids = Poison.decode!(params["ids"])
    query = from u in Booker.Auth.User,
              where: u.id in ^ids,
              select: u
    response = query |> Repo.all

    render(conn, "index.json", users: response)
  end

  def register(conn, %{"email" => email, "first_name" => name, "last_name"=> surname, "password" => password, "cpassword" => re_password}) do
     case password == re_password do
      true ->
        with {:ok, %User{} = user} <- Auth.create_user(%{ "email" => email, "name" => name, "surname"=> surname, "password" => password }) do
          conn
            |> put_status(:created)
            |> render("show.json", user: user)
        end
      false ->
        # TODO: Handle different types of error
        conn |> halt
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

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
        |> put_status(:created)
        |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

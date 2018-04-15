require IEx
defmodule BookerWeb.UserController do
  use BookerWeb, :controller

  alias Booker.Auth
  alias Booker.Auth.User
  alias Booker.Auth.Guardian
  alias Booker.Repo

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
  Search for users based on provided query. It can be name or surname or name and surname. We replace spaces with | so full text search in Postgres.

  Returns [User]
  """
  def search_user(conn, %{"query" => query}) do
    formatted = query |> String.replace(" ", "|")
    users = Repo.execute_and_load("SELECT * FROM users WHERE id IN (SELECT searchable_id FROM searches WHERE to_tsvector('english', term) @@ to_tsquery($1));", [ formatted ], User)
    IEx.pry()
    conn
      |> put_status(:ok)
      |> render("index.json", users: users)
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
        conn |> halt
     end
  end

  def check_auth(conn, %{"token" => token}) do
    case Guardian.resource_from_token(token) do
      {:ok, %Booker.Auth.User{} = user, _} ->
        render(conn, "token.json", token: token, user: user )
      {:error, _} ->
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

  # TODO: handle errors
  defp login_reply({:ok, user}, conn) do
    {:ok, token, _} = Guardian.encode_and_sign(user)
    render conn, "token.json", token: token, user: user
  end
end

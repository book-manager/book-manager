defmodule BookerWeb.UserController do
  use BookerWeb, :controller

  alias Booker.Auth
  alias Booker.Auth.User
  alias Booker.Auth.Guardian

  action_fallback BookerWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    Auth.authenticate_user(email, password)
      |> login_reply(conn)
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
    render conn, "token.json", token: token
  end
end

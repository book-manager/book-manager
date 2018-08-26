require Logger
require IEx
defmodule BookerWeb.FriendshipController do
  use BookerWeb, :controller

  alias Booker.Auth
  alias Booker.Auth.{Friendship, User}
  alias Booker.Repo

  import Ecto.Query
  alias Ecto.Changeset

  action_fallback(BookerWeb.FallbackController)

  def create(conn, %{"friend_id" => friend_id}) do
    current_user = conn.assigns.current_user
    friend = Auth.get_user!(friend_id)

    friendship = %Friendship{friend: friend, user: current_user} |> Repo.insert!

    render conn, "show.json-api", data: friendship
  end

  def check_friendship(conn, %{"id" => friend_id}) do
    id = conn.assigns.current_user.id
    query = from f in Friendship,
            where: f.user_id == ^id and f.friend_id == ^friend_id,
            select: f

    friendship = Repo.all(query)

    case friendship do
      [] ->
        render conn, "show.json-api", data: %{}
      [%Friendship{} = result] ->
        render conn, "show.json-api", data: result
    end
  end

  def check_friendship_incoming(conn, %{"id" => friend_id}) do
    id = conn.assigns.current_user.id
    query = from f in Friendship,
            where: f.user_id == ^friend_id and f.friend_id == ^id,
            select: f

    friendship = Repo.all(query)
    case friendship do
      [] ->
        render conn, "show.json-api", data: %{}
      [%Friendship{} = result] ->
        render conn, "show.json-api", data: result
      [_ | _] ->
        render conn, "show.json-api", data: %{}
    end
  end

  def index(conn, params) do
    current_user = conn.assigns.current_user |> Repo.preload(:friends)
    friends = current_user.friends
    render conn, "index.json-api", data: friends
  end

  def pending_requests(conn, _params) do
    current_user_id = conn.assigns.current_user.id
    query = from f in Friendship,
            join: u in User,
            on: u.id == f.user_id,
            where: f.pending == true and f.friend_id == ^current_user_id,
            select: u

    friendships = Repo.all(query)

    Logger.debug("Pending requests list: #{inspect friendships}")

    render conn, BookerWeb.UserView, "index.json-api", data: friendships
  end

  def accept(conn, %{"id" => id}) do
    current_user_id = conn.assigns.current_user.id
    query = from f in Friendship,
            where: f.pending == true and f.user_id == ^id and f.friend_id == ^current_user_id,
            select: f

    friendship = Repo.all(query) |> List.first
    friendship_changeset = Changeset.change(friendship, %{pending: false})
    Repo.update!(friendship_changeset)


    current_user = conn.assigns.current_user
    friend = Auth.get_user!(id)

    friendship = %Friendship{friend: friend, user: current_user, pending: false} |> Repo.insert!

    render conn, "show.json-api", data: friendship
  end
end

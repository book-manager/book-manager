require Logger

defmodule BookerWeb.FriendshipController do
  use BookerWeb, :controller

  alias Booker.Auth
  alias Booker.Auth.Friendship
  alias Booker.Auth.User
  alias Booker.Books.BookOwnership
  alias Booker.Repo

  import Ecto.Query

  action_fallback(BookerWeb.FallbackController)

  def create(conn, %{"friend_id" => friend_id}) do
    current_user = conn.assigns.current_user
    # check if friend request exists

    query =
      from(f in Booker.Auth.Friendship,
        where: f.friend_b_id == ^current_user.id and f.friend_a_id == ^friend_id,
        select: f
      )

    response = query |> Repo.all()

    case response do
      [] ->
        with {:ok, %Friendship{} = friendship} <-
               Auth.create_friendship(%{
                 friend_a_id: current_user.id,
                 friend_b_id: friend_id,
                 pending: true
               }) do
          conn
          |> put_status(:created)
          |> render("show.json", friendship: friendship)
        end

      [%Friendship{pending: true}] ->
        friendship = response |> List.first()
        Auth.update_friendship(friendship, %{pending: false})

        conn
        |> put_status(:created)
        |> render("show.json", friendship: friendship)
    end
  end

  def check_friendship(conn, %{"friend_id" => friend_id}) do
    current_user_id = conn.assigns.current_user.id

    # Check if we send request to that user
    outgoing_query =
      from(u in Booker.Auth.Friendship,
        where: u.friend_a_id == ^current_user_id and u.friend_b_id == ^friend_id,
        select: u
      )

    response = outgoing_query |> Repo.all()

    # Check if user send us requests
    incoming_query =
      from(u in Booker.Auth.Friendship,
        where: u.friend_b_id == ^current_user_id and u.friend_a_id == ^friend_id,
        select: u
      )

    incoming_response = incoming_query |> Repo.all()

    # TODO: Probably we can use with
    case response do
      [] ->
        case incoming_response do
          [] ->
            Logger.info(
              "Friendship between #{current_user_id} and #{friend_id} is in state: false"
            )

            conn
            |> render("check-friendship.json", friendship: false)

          [%Friendship{pending: true}] ->
            Logger.info(
              "Friendship between #{current_user_id} and #{friend_id} is coming from other user"
            )

            conn
            |> render("check-friendship.json", friendship: "initiated")

          [%Friendship{pending: false}] ->
            Logger.info(
              "Friendship between #{current_user_id} and #{friend_id} is in state: true"
            )

            conn
            |> render("check-friendship.json", friendship: true)
        end

      [%Friendship{pending: true}] ->
        Logger.info("Friendship between #{current_user_id} and #{friend_id} is in state: pending")

        conn
        |> render("check-friendship.json", friendship: "pending")

      [%Friendship{pending: false}] ->
        Logger.info("Friendship between #{current_user_id} and #{friend_id} is in state: true")

        conn
        |> render("check-friendship.json", friendship: true)
    end
  end

  def index(conn, _params) do
    current_user = conn.assigns.current_user

    query =
      from(u in Booker.Auth.User,
        join: f in Booker.Auth.Friendship,
        on: f.friend_a_id == u.id,
        select: u
      )

    friendships = query |> Repo.all()

    render(conn, "index.json", friendships: friendships)
  end

  def pending_requests(conn, _params) do
    current_user_id = conn.assigns.current_user.id

    query =
      from(u in Booker.Auth.User,
        join: f in Booker.Auth.Friendship,
        on: f.friend_a_id == u.id,
        where: f.friend_b_id == ^current_user_id and f.pending == true,
        select: u
      )

    results = query |> Repo.all()
    render(conn, "index.json", friendships: results)
  end
end

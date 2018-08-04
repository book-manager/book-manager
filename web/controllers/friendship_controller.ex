defmodule Booker.FriendshipController do
  use Booker.Web, :controller

  alias Booker.Friendship

  def index(conn, _params) do
    friendships = Repo.all(Friendship)
    render(conn, "index.json", friendships: friendships)
  end

  def create(conn, %{"friendship" => friendship_params}) do
    changeset = Friendship.changeset(%Friendship{}, friendship_params)

    case Repo.insert(changeset) do
      {:ok, friendship} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", friendship_path(conn, :show, friendship))
        |> render("show.json", friendship: friendship)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Booker.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    friendship = Repo.get!(Friendship, id)
    render(conn, "show.json", friendship: friendship)
  end

  def update(conn, %{"id" => id, "friendship" => friendship_params}) do
    friendship = Repo.get!(Friendship, id)
    changeset = Friendship.changeset(friendship, friendship_params)

    case Repo.update(changeset) do
      {:ok, friendship} ->
        render(conn, "show.json", friendship: friendship)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Booker.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    friendship = Repo.get!(Friendship, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(friendship)

    send_resp(conn, :no_content, "")
  end
end

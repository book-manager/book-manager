require IEx
require Logger
defmodule BookerWeb.AuthorsController do
  use BookerWeb, :controller
  import Ecto.Query

  alias Booker.Repo
  alias Booker.Author
  alias Booker.Author.Authors
  alias Booker.Author.Ownership

  action_fallback BookerWeb.FallbackController

  def index(conn, _params) do
    current_user_id = conn.assigns.current_user.id
    query = from o in Ownership,
            join: a in Authors,
            on: o.id == a.id,
            where: o.user_id == ^current_user_id,
            select: a

    authors = query |> Repo.all
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => authors_params}) do
    current_user_id = conn.assigns.current_user.id
    name = authors_params["name"]
    surname = authors_params["surname"]

    # Check if we already have that author in DB
    query = from a in Booker.Author.Authors,
            where: a.name == ^name and a.surname == ^surname,
            select: a

    authors = query |> Repo.all

    case authors do
      [] ->
        Logger.debug("We don`t have author with name #{authors_params["name"]} and surname #{authors_params["surname"]}")
        with {:ok, %Authors{} = authors} <- Author.create_authors(authors_params) do
          with {:ok, %Ownership{} = ownership} <- Author.create_ownership(%{user_id: current_user_id, author_id: authors.id}) do
            conn
            |> put_status(:created)
            |> render("index.json", authors: authors)
          end
        end
      [%Authors{name: name, id: id}] ->
        Logger.debug("We already have that author in DB, create ownership relation")
        ownership = Repo.get_by(Ownership, author_id: id, user_id: current_user_id)
        case ownership do
          %Booker.Author.Ownership{} ->
            Logger.debug("User already has that author in collection")
            conn
              |> put_status(:unprocessable_entity)
              |> render(BookerWeb.ChangesetView, "error.json", changeset: "You already have that author in your collection")
          nil ->
            Logger.debug("Creating ownership between #{current_user_id} and #{id}")
            with {:ok, %Ownership{} = ownership} <- Author.create_ownership(%{user_id: current_user_id, author_id: id}) do
              conn
              |> put_status(:created)
              |> render("index.json", authors: authors)
            end
        end
    end
  end

  def show(conn, %{"id" => id}) do
    authors = Author.get_authors!(id)
    render(conn, "show.json", authors: authors)
  end

  def update(conn, %{"id" => id, "authors" => authors_params}) do
    authors = Author.get_authors!(id)

    with {:ok, %Authors{} = authors} <- Author.update_authors(authors, authors_params) do
      render(conn, "show.json", authors: authors)
    end
  end

  def delete(conn, %{"id" => id}) do
    authors = Author.get_authors!(id)
    with {:ok, %Authors{}} <- Author.delete_authors(authors) do
      send_resp(conn, :no_content, "")
    end
  end
end

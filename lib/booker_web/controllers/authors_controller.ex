require Logger
defmodule BookerWeb.AuthorsController do
  use BookerWeb, :controller
  import Ecto.Query

  alias Booker.Author
  alias Booker.Author.{Authors, Ownership}
  alias Booker.Books.{Book, BookOwnership}

  alias Booker.Repo

  action_fallback BookerWeb.FallbackController

  @doc """
  List authors owned by current user

  Returns [Author]
  """
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

  @doc """
  Creates Author and Ownership.
  If Author is already present in database, we just create ownership relation between Author and User.
  If the given author is new, we create new row im authors table and relation in ownership table.

  Returns [Author]
  """
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
      [%Authors{id: id}] ->
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

  @doc """
  Get data about one author by id

  Returns Author
  """
  def show(conn, %{"id" => id}) do
    authors = Author.get_authors!(id)
    render(conn, "show.json", authors: authors)
  end

  def search(conn, %{"query" => query}) do
    formatted = query |> String.replace(" ", "|")
    # TODO: Move this to Author module
    authors = Repo.execute_and_load("SELECT * FROM authors WHERE id IN (SELECT searchable_id FROM author_search WHERE to_tsvector('english', select_term) @@ to_tsquery($1));", [ formatted ], Authors)

    conn
      |> put_status(:ok)
      |> render("index.json", authors: authors)
  end

  def owned(conn, %{"id" => id}) do
    current_user_id = conn.assigns.current_user.id
    author = Repo.get_by(Ownership, author_id: id, user_id: current_user_id)

    case author do
      %Ownership{} ->
        conn |> put_status(:ok) |> render("owned.json", owned: true)
      nil ->
        conn |> put_status(:ok) |> render("owned.json", owned: false)
    end
  end

  def create_ownership(conn, %{"author_id" => author_id}) do
    current_user_id = conn.assigns.current_user.id

    with {:ok, %Ownership{} = ownership} <- Author.create_ownership(%{user_id: current_user_id, author_id: author_id}) do
      conn
      |> put_status(:created)
      |> render("owned.json", owned: true)
    end
  end

  @doc """
  Returns books that are authored by given author id

  Return [Book]
  """
  @spec books(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def books(conn, %{"id" => author_id}) do
    current_user_id = conn.assigns.current_user.id

    query = from b in Book,
            where: b.author_id == ^author_id,
            select: b
    books = query |> Repo.all()
    books_owned_query = from b in BookOwnership,
        join: book in Book,
        on: book.id == b.book_id,
        where: b.user_id == ^current_user_id and book.author_id == ^author_id,
        select: book

    owned_books = books_owned_query |> Repo.all()

    # TODO: Make sure we don't have empty value as first element
    b = Enum.reduce books, %{}, fn x, acc ->
      if Enum.member?(owned_books, x) do
        # [acc | [Map.put(x, :owned, true)]]
        Map.put(acc, x, Map.put(x, :owned, true))
      else
        Map.put(acc, x, Map.put(x, :owned, false))
        # [acc | [x]]
      end
    end
    conn |> put_status(200) |> render(BookerWeb.BookView, "index_owned.json", books: b |> Map.values())
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

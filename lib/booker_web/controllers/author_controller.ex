defmodule BookerWeb.AuthorController do
  use BookerWeb, :controller

  require Logger
  require IEx

  import Ecto.Query

  alias Booker.Authors
  alias Booker.Authors.Author
  alias Booker.Books.{Book, BookOwnership}
  alias Booker.Repo
  alias Ecto.Changeset

  action_fallback(BookerWeb.FallbackController)

  @doc """
  List authors owned by current user

  Returns [Author]
  """
  def index(conn, _params) do
    current_user = conn.assigns.current_user |> Repo.preload(:authors)
    authors = current_user.authors |> Repo.preload([:books])

    render(conn, "index.json", authors: authors)
  end

  def avatar(conn, params) do
    response = Services.Images.upload_author_avatar(params["name"], params["file"])

    conn |> put_status(200)
  end

  @doc """
  Creates Author and Ownership.
  If Author is already present in database, we just create ownership relation between Author and User.
  If the given author is new, we create new row im authors table and relation in ownership table.

  Returns [Author]
  """
  def create(conn, %{"author" => author_params}) do
    current_user = Repo.preload(conn.assigns.current_user, :authors)

    case Repo.get_by(Author, name: author_params["name"], surname: author_params["surname"]) do
      %Author{} = author ->
        authors = [author] ++ current_user.authors

        current_user
        |> Repo.preload(:authors)
        |> Changeset.change()
        |> Changeset.put_assoc(:authors, authors)
        |> Repo.update!()

        conn |> put_status(201) |> render("author.json", author: author)

      _ ->
        {:ok, author} = Authors.create_author(author_params)
        authors = [author] ++ current_user.authors

        current_user
        |> Repo.preload(:authors)
        |> Changeset.change()
        |> Changeset.put_assoc(:authors, authors)
        |> Repo.update!()

        conn |> put_status(201) |> render("author.json", author: author)
    end
  end

  @doc """
  Get data about one author by id

  Returns Author
  """
  def show(conn, %{"id" => id}) do
    current_user_id = conn.assigns.current_user.id

    author = Authors.get_author!(id)

    query =
      from(b in Book,
        where: b.author_id == ^id,
        select: b
      )

    books = query |> Repo.all()

    books_owned_query =
      from(b in BookOwnership,
        join: book in Book,
        on: book.id == b.book_id,
        where: b.user_id == ^current_user_id and book.author_id == ^id,
        select: book
      )

    owned_books = books_owned_query |> Repo.all()

    # TODO: Check performance
    b =
      Enum.reduce(books, %{}, fn x, acc ->
        if Enum.member?(owned_books, x) do
          Map.put(acc, x.id, Map.put(x, :owned, true))
        else
          Map.put(acc, x.id, Map.put(x, :owned, false))
        end
      end)

    author_books = %{author | books: Map.values(b)}

    render(conn, "author-books-owned.json", author: author_books)
  end

  def search(conn, %{"query" => query}) do
    formatted = query |> String.replace(" ", "|")
    # TODO: Move this to Author module
    authors =
      Repo.execute_and_load(
        "SELECT * FROM authors WHERE id IN (SELECT searchable_id FROM author_search WHERE to_tsvector('english', select_term) @@ to_tsquery($1));",
        [formatted],
        Author
      )
      |> Repo.preload([:books])

    render(conn, "index-books.json", authors: authors)
  end
end

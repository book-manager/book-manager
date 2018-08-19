require Logger
defmodule BookerWeb.BookController do
  use BookerWeb, :controller

  alias Booker.Books
  alias Booker.Books.Book
  alias Booker.Books.BookOwnership
  alias Booker.Repo

  alias Booker.Repo

  import Ecto.Query

  action_fallback(BookerWeb.FallbackController)

  def index(conn, _params) do
    books = Books.list_books()
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    current_user_id = conn.assigns.current_user.id
    isbn = book_params["isbn"]

    # Upload cover photo
    case HTTPoison.post(
           "http://localhost:4567/book",
           Poison.encode!(%{image: book_params["imgData"], name: book_params["imageName"]})
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        cover_response = Poison.decode!(body)

        params =
          Map.drop(book_params, ["imageName", "imgData"])
          |> Map.put("cover_url", cover_response["object_url"])
          |> Map.put("thumbnail_url", cover_response["cover_url"])

        # check if we alrady have that book
        book = Repo.get_by(Book, isbn: isbn)

        case book do
          %Book{} ->
            Logger.debug("We already have book #{isbn} in db")

            with {:ok, %BookOwnership{} = book_ownership} <-
                   Books.create_book_ownership(%{user_id: current_user_id, book_id: book.id}) do
              conn |> put_status(:created) |> render("show.json", book: book)
            end

          nil ->
            with {:ok, %Book{} = book} <- Books.create_book(params) do
              with {:ok, %BookOwnership{} = book_ownership} <-
                     Books.create_book_ownership(%{user_id: current_user_id, book_id: book.id}) do
                conn |> put_status(:created) |> render("show.json", book: book)
              end
            end
        end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, 404}
    end
  end

  def show(conn, %{"id" => id}) do
    query =
      from(b in Booker.Books.Book,
        join: a in Booker.Author.Authors,
        on: a.id == b.author_id,
        where: b.id == ^id,
        select: %{
          id: b.id,
          title: b.title,
          cover_url: b.cover_url,
          thumbnail: b.thumbnail_url,
          author_id: a.id,
          author_name: a.name,
          author_surname: a.surname,
          description: b.description
        }
      )

    response = query |> Repo.one()
    render(conn, "show.json", book: response)
  end

  @doc """
  Checks if user owns given book

  Returns BookOwnership
  """
  def owned(conn, %{"id" => id}) do
    current_user_id = conn.assigns.current_user.id
    ownership = Repo.get_by(BookOwnership, book_id: id, user_id: current_user_id)

    case ownership do
      %BookOwnership{} ->
        conn |> render(BookerWeb.BookOwnershipView, "show_owned.json", book_ownership: ownership)
      nil ->
        conn |> render(BookerWeb.BookOwnershipView, "show_unowned.json", book_ownership: false)
    end
  end

  @doc """
  Creates ownership between User and given author.

  Returns Ownership.
  """
  def create_ownership(conn, %{"book_id" => book_id}) do
    current_user_id = conn.assigns.current_user.id

    with {:ok, %BookOwnership{} = ownership} <-
           Books.create_book_ownership(%{user_id: current_user_id, book_id: book_id}) do
      conn
      |> put_status(201)
      |> render(BookerWeb.BookOwnershipView, "show.json", book_ownership: ownership)
    end
  end

  @doc """
  Return rating given to this book by community

  Returns Integer
  """
  # def show_rating(conn, %{"book_id" => book_id}) do
  #   current_user_id = conn.assigns.current_user.id
  #   ownership = Repo.get_by(BookOwnership, book_id: id, user_id: current_user_id)

  #   case ownership do
  #     %BookOwnership{} ->

  #   end
  # end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Books.get_book!(id)

    with {:ok, %Book{} = book} <- Books.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Books.get_book!(id)

    with {:ok, %Book{}} <- Books.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end

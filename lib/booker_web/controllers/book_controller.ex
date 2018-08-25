require Logger
defmodule BookerWeb.BookController do
  use BookerWeb, :controller

  alias Booker.Books
  alias Booker.Books.{Book, BookOwnership}
  alias Booker.Repo

  alias Booker.Repo

  import Ecto.Query

  action_fallback(BookerWeb.FallbackController)

  @doc """
  Return books owned by current user
  """
  def index(conn, _params) do
    current_user_id = conn.assigns.current_user.id
    query = from o in BookOwnership,
            join: b in Book,
            on: b.id == o.book_id,
            where: o.user_id == ^current_user_id,
            select: b

    books = query |> Repo.all |> Repo.preload([:author])
    render conn, "index.json-api", data: books, opts: [include: "author"]
  end

  @doc """
  Return books owned by friends
  """
  def index_friends(conn, _params) do
    current_user_id = conn.assigns.current_user.id

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
    book = Books.get_book!(id) |> Repo.preload([:author])

    render conn, "show.json-api", data: book, opts: [include: "author"]
  end

  @doc """
  Checks if user owns given book

  Returns BookOwnership
  """
  def owned(conn, %{"id" => id}) do
    current_user_id = conn.assigns.current_user.id
    ownership = Repo.get_by(BookOwnership, book_id: id, user_id: current_user_id)

    case ownership do
      %BookOwnership{read: read} ->
        render conn, BookerWeb.BookOwnershipView, "show.json-api", data: %{owned: true, read: read}
        # conn |> render(BookerWeb.BookOwnershipView, "show_owned.json", book_ownership: ownership)
      nil ->
        render conn, BookerWeb.BookOwnershipView, "show.json-api", data: %{owned: false}
        # conn |> render(BookerWeb.BookOwnershipView, "show_unowned.json", book_ownership: false)
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

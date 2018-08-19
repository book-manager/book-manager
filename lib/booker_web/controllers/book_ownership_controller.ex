require IEx
defmodule BookerWeb.BookOwnershipController do
  use BookerWeb, :controller

  alias Booker.Books
  alias Booker.Books.BookOwnership

  alias Booker.Repo

  action_fallback(BookerWeb.FallbackController)

  def index(conn, _params) do
    book_ownership = Books.list_book_ownership()
    render(conn, "index.json", book_ownership: book_ownership)
  end

  def create(conn, %{"book_ownership" => book_ownership_params}) do
    with {:ok, %BookOwnership{} = book_ownership} <-
           Books.create_book_ownership(book_ownership_params) do
      conn
      |> put_status(:created)
      |> render("show.json", book_ownership: book_ownership)
    end
  end

  def show(conn, %{"id" => id}) do
    book_ownership = Books.get_book_ownership!(id)
    render(conn, "show.json", book_ownership: book_ownership)
  end

  @doc """
  Updates ownership with given values.

  IMPORTANT: ID in here is Book ID, not book ownership itself, so it will update book_ownership of current user and given Book.
  """
  @spec update(any(), map()) :: any()
  def update(conn, %{"id" => id, "book_ownership" => book_ownership_params}) do
    current_user_id = conn.assigns.current_user.id
    book_ownership = Repo.get_by!(BookOwnership, user_id: current_user_id, book_id: id)

    with {:ok, %BookOwnership{} = book_ownership} <-
           Books.update_book_ownership(book_ownership, book_ownership_params) do
      render(conn, "show.json", book_ownership: book_ownership)
    end
  end

  def delete(conn, %{"id" => id}) do
    book_ownership = Books.get_book_ownership!(id)

    with {:ok, %BookOwnership{}} <- Books.delete_book_ownership(book_ownership) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule BookerWeb.BookOwnershipController do
  use BookerWeb, :controller

  alias Booker.Books
  alias Booker.Books.BookOwnership

  action_fallback BookerWeb.FallbackController

  def index(conn, _params) do
    book_ownership = Books.list_book_ownership()
    render(conn, "index.json", book_ownership: book_ownership)
  end

  def create(conn, %{"book_ownership" => book_ownership_params}) do
    with {:ok, %BookOwnership{} = book_ownership} <- Books.create_book_ownership(book_ownership_params) do
      conn
      |> put_status(:created)
      |> render("show.json", book_ownership: book_ownership)
    end
  end

  def show(conn, %{"id" => id}) do
    book_ownership = Books.get_book_ownership!(id)
    render(conn, "show.json", book_ownership: book_ownership)
  end

  def update(conn, %{"id" => id, "book_ownership" => book_ownership_params}) do
    book_ownership = Books.get_book_ownership!(id)

    with {:ok, %BookOwnership{} = book_ownership} <- Books.update_book_ownership(book_ownership, book_ownership_params) do
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

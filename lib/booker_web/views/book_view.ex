defmodule BookerWeb.BookView do
  use BookerWeb, :view
  alias BookerWeb.BookView

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("index_owned.json", %{books: books}) do
    %{data: render_many(books, BookView, "book_owned.json")}
  end

  def render("owned.json", %{owned: owned}) do
    %{owned: owned}
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      title: book.title,
      isbn: book.isbn,
      description: book.description,
      cover_url: book.cover_url,
      thumbnail_url: book.thumbnail_url
    }
  end

  def render("book_owned.json", %{book: book}) do
    %{
      id: book.id,
      title: book.title,
      isbn: book.isbn,
      description: book.description,
      cover_url: book.cover_url,
      thumbnail_url: book.thumbnail_url,
      owned: book.owned
    }
  end
end

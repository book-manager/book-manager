defmodule BookerWeb.BookView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :id,
    :title,
    :isbn,
    :description,
    :cover_url,
    :thumbnail_url
  ]

  has_one :author,
    serializer: BookerWeb.AuthorView,
    include: true,
    identifiers: :when_included

  def type do
    "Book"
  end
  # alias BookerWeb.BookView

  # def render("index.json", %{books: books}) do
  #   %{data: render_many(books, BookView, "book.json")}
  # end

  # def render("index_owned.json", %{books: books}) do
  #   %{data: render_many(books, BookView, "book_owned.json")}
  # end

  # def render("show.json", %{book: book}) do
  #   %{data: book}
  # end

  # def render("owned.json", %{owned: owned}) do
  #   %{owned: owned}
  # end

  # def render("book.json", %{book: book}) do
  #   %{id: book.id,
  #     title: book.title,
  #     isbn: book.isbn,
  #     description: book.description,
  #     cover_url: book.cover_url,
  #     thumbnail_url: book.thumbnail_url}
  # end

  # def render("book_owned.json", %{book: book}) do
  #   %{id: book.id,
  #     title: book.title,
  #     isbn: book.isbn,
  #     description: book.description,
  #     cover_url: book.cover_url,
  #     thumbnail_url: book.thumbnail_url,
  #     owned: book.owned}
  # end
end

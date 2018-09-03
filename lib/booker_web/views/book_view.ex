defmodule BookerWeb.BookView do
  use BookerWeb, :view
  alias BookerWeb.{AuthorView, BookView}

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("index_with_authors.json", %{books: books}) do
    %{data: render_many(books, BookView, "book_with_author.json")}
  end

  def render("show.json", %{book: book}) do
    %{book: render_one(book, BookView, "book.json")}
  end

  def render("show_with_author.json", %{book: book}) do
    %{book: render_one(book, BookView, "book_with_author.json")}
  end

  def render("book.json", %{book: book}) do
    book
    |> Map.from_struct()
    |> Map.take([:id, :title, :isbn, :description, :cover_url, :thumbnail_url])
  end

  def render("book_with_author.json", %{book: book}) do
    book
    |> Map.from_struct()
    |> Map.take([:id, :title, :isbn, :description, :cover_url, :thumbnail_url])
    |> Map.put(:author, AuthorView.render("show.json", author: book.author))
  end
end

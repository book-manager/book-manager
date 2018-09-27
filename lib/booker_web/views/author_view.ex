defmodule BookerWeb.AuthorView do
  use BookerWeb, :view
  alias BookerWeb.{AuthorView, BookView}

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("index-books.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author-books.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id, name: author.name, surname: author.surname, avatar_url: author.avatar_url, description: author.description}
  end

  def render("author-books.json", %{author: author}) do
    %{id: author.id, name: author.name, surname: author.surname, avatar_url: author.avatar_url, description: author.description, books: render_many(author.books, BookView, "book.json")}
  end

  def render("author-books-owned.json", %{author: author}) do
    %{id: author.id, name: author.name, surname: author.surname, avatar_url: author.avatar_url, description: author.description, books: render_many(author.books, BookView, "book_owned.json")}
  end
end

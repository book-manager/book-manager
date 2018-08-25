defmodule BookerWeb.AuthorView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [:id, :name, :surname, :description, :avatar_url]

  has_many :books,
    serializer: BookerWeb.BookView,
    include: false,
    identifiers: :when_included

  def type do
      "Author"
  end
  # alias BookerWeb.AuthorView

  # def render("index.json", %{authors: authors}) do
  #   %{data: render_many(authors, AuthorView, "author.json")}
  # end

  # def render("show.json", %{author: author}) do
  #   %{data: render_one(author, AuthorView, "author.json")}
  # end

  # def render("owned.json", %{owned: owned}) do
  #   %{owned: owned}
  # end

  # def render("author.json", %{author: author}) do
  #   %{id: author.id,
  #     name: author.name,
  #     surname: author.surname,
  #     description: author.description,
  #     avatar_url: author.avatar_url,
  #     books: render_books(author.books)}
  # end

  # defp render_books(books) do
  #   render_many(books, BookerWeb.BookView, "index.json")
  # end
end

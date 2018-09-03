defmodule BookerWeb.AuthorView do
  use BookerWeb, :view
  alias BookerWeb.{AuthorView, BookView}

  def render("index.json", %{authors: authors}) do
    %{authors: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{author: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    author
    |> Map.from_struct()
    |> Map.take([:id, :name, :surname, :description, :avatar_url])
    |> Map.put(:books, BookView.render("index.json", %{books: author.books}))
  end
end

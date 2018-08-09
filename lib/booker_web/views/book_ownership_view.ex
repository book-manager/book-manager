defmodule BookerWeb.BookOwnershipView do
  use BookerWeb, :view
  alias BookerWeb.BookOwnershipView

  def render("index.json", %{book_ownership: book_ownership}) do
    %{data: render_many(book_ownership, BookOwnershipView, "book_ownership.json")}
  end

  def render("show.json", %{book_ownership: book_ownership}) do
    %{data: render_one(book_ownership, BookOwnershipView, "book_ownership.json")}
  end

  def render("book_ownership.json", %{book_ownership: book_ownership}) do
    %{id: book_ownership.id}
  end
end

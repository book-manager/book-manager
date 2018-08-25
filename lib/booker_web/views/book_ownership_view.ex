defmodule BookerWeb.BookOwnershipView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :id,
    :owned,
    :read
  ]
  # alias BookerWeb.BookOwnershipView

  # def render("index.json", %{book_ownership: book_ownership}) do
  #   %{data: render_many(book_ownership, BookOwnershipView, "book_ownership.json")}
  # end

  # def render("show.json", %{book_ownership: book_ownership}) do
  #   %{data: render_one(book_ownership, BookOwnershipView, "book_ownership.json")}
  # end

  # def render("show_owned.json", %{book_ownership: book_ownership}) do
  #   %{data: %{owned: true, read: book_ownership.read}}
  # end

  # def render("show_unowned.json", %{book_ownership: false}) do
  #   %{data: %{owned: false, read: false}}
  # end

  # def render("book_ownership.json", %{book_ownership: book_ownership}) do
  #   %{id: book_ownership.id, read: book_ownership.read}
  # end
end

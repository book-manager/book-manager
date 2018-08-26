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
end

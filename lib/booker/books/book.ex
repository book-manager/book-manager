defmodule Booker.Books.Book do
  @moduledoc """
  Book entity representing book in Booker.

  Most important think is ISBN number, it should be unique in the whole system.
  """

  use Ecto.Schema
  import Ecto.Changeset


  schema "books" do
    field :description, :string
    field :isbn, :string
    field :title, :string
    field :cover_url, :string
    field :thumbnail_url, :string
    field :author_id, :id
    field :rating, :integer

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :description, :author_id, :cover_url, :thumbnail_url, :rating])
    |> validate_required([:title, :isbn, :description, :author_id])
  end
end

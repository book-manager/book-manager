defmodule Booker.Books.Book do
  @moduledoc """
  Book entity representing book in Booker.

  Most important think is ISBN number, it should be unique in the whole system.
  """

  import Ecto.Changeset
  use Ecto.Schema

  alias Booker.Authors.Author

  schema "books" do
    field :description, :string
    field :isbn, :string
    field :title, :string
    field :cover_url, :string
    field :thumbnail_url, :string
    field :rating, :integer

    timestamps()

    belongs_to :author, Author
  end

  @required_fields [
    :title,
    :isbn,
    :description
  ]

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :description, :cover_url, :thumbnail_url, :rating])
    |> validate_required(@required_fields)
  end
end

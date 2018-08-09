defmodule Booker.Books.BookOwnership do
  use Ecto.Schema
  import Ecto.Changeset


  schema "book_ownership" do
    field :book_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(book_ownership, attrs) do
    book_ownership
    |> cast(attrs, [:book_id, :user_id])
    |> validate_required([:book_id, :user_id])
  end
end

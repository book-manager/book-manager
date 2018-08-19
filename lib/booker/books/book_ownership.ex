defmodule Booker.Books.BookOwnership do
  @moduledoc """
  Entity that represents connection between User and Book. This entity should be used as representation of ownership of physical book.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_ownership" do
    field :book_id, :id
    field :user_id, :id
    field :read, :boolean
    field :rating, :integer

    timestamps()
  end

  @doc false
  def changeset(book_ownership, attrs) do
    book_ownership
    |> cast(attrs, [:book_id, :user_id, :read])
    |> validate_required([:book_id, :user_id])
  end
end

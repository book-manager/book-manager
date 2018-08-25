defmodule Booker.Authors.Author do
  import Ecto.Changeset
  use Ecto.Schema

  alias Booker.Auth.User
  alias Booker.Books.Book
  alias Booker.Authors.Ownership

  schema "authors" do
    field :birth_date, :naive_datetime
    field :description, :string
    field :name, :string
    field :surname, :string
    field :avatar_url, :string

    timestamps()

    has_many :books, Book, on_delete: :delete_all
    many_to_many :users, User, join_through: Ownership
  end

  @doc false
  def changeset(authors, attrs) do
    authors
    |> cast(attrs, [:name, :surname, :description, :avatar_url])
    |> validate_required([:name, :surname, :description])
    |> cast_assoc(:users)
  end
end

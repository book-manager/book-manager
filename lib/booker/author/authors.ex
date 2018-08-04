defmodule Booker.Author.Authors do
  use Ecto.Schema
  import Ecto.Changeset


  schema "authors" do
    field :birth_date, :naive_datetime
    field :description, :string
    field :name, :string
    field :surname, :string
    field :avatar_url, :string

    timestamps()
  end

  @doc false
  def changeset(authors, attrs) do
    authors
    |> cast(attrs, [:name, :surname, :description, :avatar_url])
    |> validate_required([:name, :surname, :description])
  end
end

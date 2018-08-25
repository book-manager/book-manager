defmodule Booker.Authors.Ownership do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ownership" do
    field :user_id, :id
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(ownership, attrs) do
    ownership
    |> cast(attrs, [:user_id, :author_id])
    |> validate_required([:user_id, :author_id])
    |> unique_constraint(:unique_author_user, name: :index_unique_user_author)
  end
end

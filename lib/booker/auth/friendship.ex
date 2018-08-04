defmodule Booker.Auth.Friendship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friendships" do
    field :friend_a_id, :id
    field :friend_b_id, :id
    field :pending, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:friend_a_id, :friend_b_id, :pending])
    |> validate_required([])
  end
end

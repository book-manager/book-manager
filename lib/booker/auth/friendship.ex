defmodule Booker.Auth.Friendship do
  @moduledoc """
  Represents friendship between two users
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Booker.Auth.User

  schema "friendships" do
    belongs_to :user, User
    belongs_to :friend, User

    field :pending, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:friend, :user, :pending, :user_id, :friend_id])
    |> validate_required([])
  end
end

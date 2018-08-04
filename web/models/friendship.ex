defmodule Booker.Friendship do
  use Booker.Web, :model

  schema "friendships" do
    belongs_to :friend_a, Booker.FriendA, foreign_key: :friend_a_id
    belongs_to :friend_b, Booker.FriendB, foreign_key: :friend_b_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end

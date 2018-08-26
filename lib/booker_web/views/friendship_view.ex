defmodule BookerWeb.FriendshipView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :pending,
    :user_id,
    :friend_id
  ]
end

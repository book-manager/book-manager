defmodule Booker.FriendshipView do
  use Booker.Web, :view

  def render("index.json", %{friendships: friendships}) do
    %{data: render_many(friendships, Booker.FriendshipView, "friendship.json")}
  end

  def render("show.json", %{friendship: friendship}) do
    %{data: render_one(friendship, Booker.FriendshipView, "friendship.json")}
  end

  def render("friendship.json", %{friendship: friendship}) do
    %{id: friendship.id,
      friend_a: friendship.friend_a,
      friend_b: friendship.friend_b}
  end
end

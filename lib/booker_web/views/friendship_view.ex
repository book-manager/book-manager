defmodule BookerWeb.FriendshipView do
  use BookerWeb, :view
  alias BookerWeb.FriendshipView

  def render("index.json", %{friendships: friendships}) do
    %{data: render_many(friendships, FriendshipView, "friendship_user.json")}
  end

  def render("show.json", %{friendship: friendship}) do
    %{data: render_one(friendship, FriendshipView, "friendship.json")}
  end

  def render("friendship_user.json", %{friendship: friendship}) do
     %{id: friendship.id, name: friendship.name, surname: friendship.surname, avatar_url: friendship.avatar_url}
  end

  def render("friendship.json", %{friendship: friendship}) do
    %{id: friendship.id}
  end

  def render("check-friendship.json", %{friendship: friendship}) do
    %{friendship: friendship}
  end
end

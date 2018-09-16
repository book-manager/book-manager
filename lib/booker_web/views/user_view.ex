defmodule BookerWeb.UserView do
  use BookerWeb, :view

  alias BookerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name, surname: user.surname, avatar_url: user.avatar_url, email: user.email}
  end

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end

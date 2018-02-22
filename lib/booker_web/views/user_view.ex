defmodule BookerWeb.UserView do
  use BookerWeb, :view
  alias BookerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("token.json", %{token: token, user: user}) do
    %{success: true, token: token, user: %{ name: user.name, surname: user.surname, avatar_url: user.avatar_url, is_admin: user.is_admin}}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name,
      surname: user.surname,
      avatar_url: user.avatar_url,
      password: user.password,
      is_admin: user.is_admin}
  end
end

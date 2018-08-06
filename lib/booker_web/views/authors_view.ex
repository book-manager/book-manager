defmodule BookerWeb.AuthorsView do
  use BookerWeb, :view
  alias BookerWeb.AuthorsView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorsView, "authors.json")}
  end

  def render("show.json", %{authors: authors}) do
    %{data: render_one(authors, AuthorsView, "authors.json")}
  end

  def render("owned.json", %{owned: owned}) do
    %{owned: owned}
  end

  def render("authors.json", %{authors: authors}) do
    %{id: authors.id,
      name: authors.name,
      surname: authors.surname,
      birth_date: authors.birth_date,
      description: authors.description,
      avatar_url: authors.avatar_url}
  end
end

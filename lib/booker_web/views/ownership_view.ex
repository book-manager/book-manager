defmodule BookerWeb.OwnershipView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :owned
  ]
  # alias BookerWeb.OwnershipView

  # def render("index.json", %{ownership: ownership}) do
  #   %{data: render_many(ownership, OwnershipView, "ownership.json")}
  # end

  # def render("show.json", %{ownership: ownership}) do
  #   %{data: render_one(ownership, OwnershipView, "ownership.json")}
  # end

  # def render("ownership.json", %{ownership: ownership}) do
  #   %{id: ownership.id}
  # end
end

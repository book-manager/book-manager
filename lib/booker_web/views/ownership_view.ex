defmodule BookerWeb.OwnershipView do
  use BookerWeb, :view

  def render("show.json", %{owned: owned}) do
    %{owned: owned}
  end
end

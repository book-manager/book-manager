defmodule BookerWeb.BookOwnershipView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :id,
    :owned,
    :read
  ]

  def typ do
    "BookOwnership"
  end
end

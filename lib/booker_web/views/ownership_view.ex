defmodule BookerWeb.OwnershipView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :owned
  ]

end

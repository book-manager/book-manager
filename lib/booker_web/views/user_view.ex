defmodule BookerWeb.UserView do
  use BookerWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :id,
    :email,
    :name,
    :surname,
    :avatar_url,
    :is_admin,
    :created_at,
    :token
  ]

  has_many :authors,
    serialized: BookerWeb.AuthorView,
    include: false,
    identifiers: :when_included

  def type do
    "User"
  end
end

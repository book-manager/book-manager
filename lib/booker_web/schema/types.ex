defmodule BookerWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :author do
    field(:id, :id)
    field(:name, :string)
    field(:surname, :string)
    field(:avatar_url, :string)
    field :description, :string

    field(:books, :book, resolve: assoc(:books))
  end

  object :book do
    field(:id, :id)
    field :title, :string
    field :description, :string

    field :author, :author, resolve: assoc(:author)
  end
end

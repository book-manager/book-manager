defmodule BookerWeb.Schema.Types do
  use Absinthe.Schema.Notation

  use Absinthe.Ecto, repo: Booker.Repo

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

  object :user do
    field :id, :id
    field :name, :string
    field :surname, :string
    field :avatar_url, :string
  end

  object :session do
    field :token, :string
    field :user, :user
  end

  object :register do
    field :name, :string
    field :surname, :string
    field :email, :string
  end
end

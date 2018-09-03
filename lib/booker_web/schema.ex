defmodule BookerWeb.Schema do
  use Absinthe.Schema

  alias Booker.Authors.AuthorResolver

  import_types(BookerWeb.Schema.Types)

  query do
    field :authors, list_of(:author) do
      resolve(&AuthorResolver.all/2)
    end

    @desc "Search for authors by name or surname"
    field :author_search, type: list_of(:author) do
      arg :query, non_null(:string)

      resolve(&AuthorResolver.search/2)
    end
  end
end

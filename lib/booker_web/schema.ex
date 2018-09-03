defmodule BookerWeb.Schema do
  use Absinthe.Schema

  import_types(BookerWeb.Schema.Types)
  query do
    field :authors, list_of(:author) do
      resolve(&Booker.Author.all/2)
    end
  end
end

defmodule BookerWeb.Schema do
  use Absinthe.Schema

  alias Booker.Auth.UserResolver

  import_types(BookerWeb.Schema.Types)

  query do
    # field :authors, list_of(:author) do
      # resolve(&Author.all/2)
    # end
  end
end

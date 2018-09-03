require Logger
require IEx
defmodule Booker.Authors.AuthorResolver do
  @moduledoc """
  Resolver for author entity
  """

  alias Booker.Repo
  alias Booker.Authors.Author

  def all(_params, %{context: %{current_user: current_user}}) do
    authors = current_user |> Repo.preload(:authors) |> Map.get(:authors)
    {:ok, %{authors: authors}}
  end

  def search(params, _context) do
    %{query: query} = params
    formatted = query |> String.replace(" ", "|")
    authors = Repo.execute_and_load("SELECT * FROM authors WHERE id IN (SELECT searchable_id FROM author_search WHERE to_tsvector('english', select_term) @@ to_tsquery($1));", [ formatted ], Author) |> Repo.preload([:books])
    Logger.debug("Authors fetched by query: #{inspect authors}")
    {:ok, %{authors: authors}}
  end
end

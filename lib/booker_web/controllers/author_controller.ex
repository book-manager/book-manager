require Logger
require IEx
defmodule BookerWeb.AuthorController do
  use BookerWeb, :controller
  import Ecto.Query

  alias Booker.Authors
  alias Booker.Authors.{Author, Ownership}
  alias Booker.Books.{Book, BookOwnership}

  alias Booker.Repo
  alias Ecto.Changeset

  action_fallback BookerWeb.FallbackController

  @doc """
  Creates Author and Ownership.
  If Author is already present in database, we just create ownership relation between Author and User.
  If the given author is new, we create new row im authors table and relation in ownership table.

  Returns [Author]
  """
  def create(conn, %{"author" => author_params}) do
    current_user = Repo.preload(conn.assigns.current_user, :authors)

    case Repo.get_by(Author, name: author_params["name"], surname: author_params["surname"]) do
      %Author{} = author ->
        authors = [author] ++ current_user.authors

        current_user
          |> Repo.preload(:authors)
          |> Changeset.change()
          |> Changeset.put_assoc(:authors, authors)
          |> Repo.update!

        render conn, "show.json", author: author

      _ ->
        author = Authors.create_author(author_params)
        authors = [author] ++ current_user.authors

        current_user
          |> Repo.preload(:authors)
          |> Changeset.change()
          |> Changeset.put_assoc(:authors, authors)
          |> Repo.update!

      render conn, "show.json", author: author
    end
  end

  @doc """
  Get data about one author by id

  Returns Author
  """
  def show(conn, %{"id" => id}) do
    author = Authors.get_author!(id) |> Repo.preload([:books])

    render conn, "show.json", author: author
  end

  def search(conn, %{"query" => query}) do
    formatted = query |> String.replace(" ", "|")
    # TODO: Move this to Author module
    authors = Repo.execute_and_load("SELECT * FROM authors WHERE id IN (SELECT searchable_id FROM author_search WHERE to_tsvector('english', select_term) @@ to_tsquery($1));", [ formatted ], Author) |> Repo.preload([:books])

    render conn, "index.json", authors: authors
  end

  def update(conn, %{"id" => id, "authors" => authors_params}) do
    authors = Authors.get_author!(id)

    with {:ok, %Author{} = authors} <- Authors.update_authors(authors, authors_params) do
      render(conn, "show.json", authors: authors)
    end
  end

  def delete(conn, %{"id" => id}) do
    authors = Authors.get_author!(id)
    with {:ok, %Author{}} <- Authors.delete_authors(authors) do
      send_resp(conn, :no_content, "")
    end
  end
end

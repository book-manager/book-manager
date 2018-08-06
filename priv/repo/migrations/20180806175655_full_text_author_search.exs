defmodule Booker.Repo.Migrations.FullTextAuthorSearch do
  use Ecto.Migration

  def change do
    execute("CREATE INDEX index_authors_on_name ON authors USING gin(to_tsvector('english', name))")
    execute("CREATE INDEX index_authors_on_surname ON authors USING gin(to_tsvector('english', surname))")

    execute("
      CREATE VIEW author_search AS

      SELECT
        authors.id AS searchable_id,
        'Authors' AS searchable_type,
        authors.name AS select_term
      FROM authors

      UNION

      SELECT
        authors.id AS searchable_id,
        'Authors' AS searchable_type,
        authors.surname AS select_term
      FROM authors
    ")
  end
end

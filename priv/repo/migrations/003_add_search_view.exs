defmodule Booker.Repo.Migrations.AddSearchView do
  use Ecto.Migration

  def change do
    execute("
      CREATE VIEW searches AS

      SELECT
        users.id AS searchable_id,
        'User' AS searchable_type,
        users.name AS term
      FROM users

      UNION

      SELECT
        users.id AS searchable_id,
        'User' AS searchable_type,
        users.surname AS term
      FROM users
    ")
  end
end

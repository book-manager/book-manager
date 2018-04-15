defmodule Booker.Repo.Migrations.AddIndexesToUsers do
  use Ecto.Migration

  def change do
    execute("CREATE INDEX index_users_on_name ON users USING gin(to_tsvector('english', name))")
    execute("CREATE INDEX index_users_on_surname ON users USING gin(to_tsvector('english', surname))")
  end
end

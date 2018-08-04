defmodule Booker.Repo.Migrations.CreateOwnership do
  use Ecto.Migration

  def change do
    create table(:ownership) do
      add :user_id, references(:users, on_delete: :nothing)
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:ownership, [:user_id])
    create index(:ownership, [:author_id])
    create unique_index(:ownership, [:user_id, :author_id], name: :index_unique_user_author)

  end
end

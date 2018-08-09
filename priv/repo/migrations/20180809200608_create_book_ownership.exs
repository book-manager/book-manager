defmodule Booker.Repo.Migrations.CreateBookOwnership do
  use Ecto.Migration

  def change do
    create table(:book_ownership) do
      add :book_id, references(:books, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:book_ownership, [:book_id])
    create index(:book_ownership, [:user_id])
  end
end

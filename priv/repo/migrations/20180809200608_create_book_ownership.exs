defmodule Booker.Repo.Migrations.CreateBookOwnership do
  @moduledoc """
  Migration that represent connection between User and Book. This entity should be used as representation on ownership of physical book.
  """
  use Ecto.Migration

  def change do
    create table(:book_ownership) do
      add :book_id, references(:books, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :read, :boolean
      add :rating, :integer

      timestamps()
    end

    create index(:book_ownership, [:book_id])
    create index(:book_ownership, [:user_id])
  end
end

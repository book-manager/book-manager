defmodule Booker.Repo.Migrations.CreateFriendship do
  use Ecto.Migration

  def change do
    create table(:friendships) do
      add :friend_a_id, references(:users, on_delete: :nothing)
      add :friend_b_id, references(:users, on_delete: :nothing)
      add :pending, :boolean, default: false, null: false

      timestamps()
    end
  end
end

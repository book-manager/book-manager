defmodule Booker.Repo.Migrations.CreateFriendship do
  use Ecto.Migration

  def change do
    create table(:friendships) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :friend_id, references(:users, on_delete: :nothing), null: false
      add :pending, :boolean, default: false, null: false

      timestamps()
    end
  end
end

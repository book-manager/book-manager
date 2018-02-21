defmodule Booker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :surname, :string
      add :avatar_url, :string
      add :password, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end

  end
end

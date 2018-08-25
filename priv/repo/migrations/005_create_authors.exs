defmodule Booker.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :surname, :string
      add :birth_date, :date
      add :description, :text
      add :avatar_url, :string

      timestamps()
    end
  end
end

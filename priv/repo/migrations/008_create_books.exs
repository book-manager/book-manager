defmodule Booker.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false
      add :isbn, :string, null: false
      add :description, :text, null: false
      add :cover_url, :string
      add :thumbnail_url, :string
      add :rating, :integer
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:books, [:title])


    create unique_index(:books, [:isbn])
  end
end

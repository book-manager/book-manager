defmodule Booker.Authors do
  @moduledoc """
  The Authors context.
  """

  import Ecto.Query, warn: false
  alias Booker.Repo

  alias Booker.Authors.Author

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Authors{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single authors.

  Raises `Ecto.NoResultsError` if the Authors does not exist.

  ## Examples

      iex> get_authors!(123)
      %Authors{}

      iex> get_authors!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a authors.

  ## Examples

      iex> create_authors(%{field: value})
      {:ok, %Authors{}}

      iex> create_authors(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a authors.

  ## Examples

      iex> update_authors(authors, %{field: new_value})
      {:ok, %Authors{}}

      iex> update_authors(authors, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = authors, attrs) do
    authors
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Authors.

  ## Examples

      iex> delete_authors(authors)
      {:ok, %Authors{}}

      iex> delete_authors(authors)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = authors) do
    Repo.delete(authors)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking authors changes.

  ## Examples

      iex> change_authors(authors)
      %Ecto.Changeset{source: %Authors{}}

  """
  def change_author(%Author{} = authors) do
    Author.changeset(authors, %{})
  end

  alias Booker.Authors.Ownership

  @doc """
  Returns the list of ownership.

  ## Examples

      iex> list_ownership()
      [%Ownership{}, ...]

  """
  def list_ownership do
    Repo.all(Ownership)
  end

  @doc """
  Gets a single ownership.

  Raises `Ecto.NoResultsError` if the Ownership does not exist.

  ## Examples

      iex> get_ownership!(123)
      %Ownership{}

      iex> get_ownership!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ownership!(id), do: Repo.get!(Ownership, id)

  @doc """
  Creates a ownership.

  ## Examples

      iex> create_ownership(%{field: value})
      {:ok, %Ownership{}}

      iex> create_ownership(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ownership(attrs \\ %{}) do
    %Ownership{}
    |> Ownership.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ownership.

  ## Examples

      iex> update_ownership(ownership, %{field: new_value})
      {:ok, %Ownership{}}

      iex> update_ownership(ownership, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ownership(%Ownership{} = ownership, attrs) do
    ownership
    |> Ownership.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ownership.

  ## Examples

      iex> delete_ownership(ownership)
      {:ok, %Ownership{}}

      iex> delete_ownership(ownership)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ownership(%Ownership{} = ownership) do
    Repo.delete(ownership)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ownership changes.

  ## Examples

      iex> change_ownership(ownership)
      %Ecto.Changeset{source: %Ownership{}}

  """
  def change_ownership(%Ownership{} = ownership) do
    Ownership.changeset(ownership, %{})
  end
end

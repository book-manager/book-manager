defmodule Booker.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Booker.Repo

  alias Booker.Books.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{source: %Book{}}

  """
  def change_book(%Book{} = book) do
    Book.changeset(book, %{})
  end

  alias Booker.Books.BookOwnership

  @doc """
  Returns the list of book_ownership.

  ## Examples

      iex> list_book_ownership()
      [%BookOwnership{}, ...]

  """
  def list_book_ownership do
    Repo.all(BookOwnership)
  end

  @doc """
  Gets a single book_ownership.

  Raises `Ecto.NoResultsError` if the Book ownership does not exist.

  ## Examples

      iex> get_book_ownership!(123)
      %BookOwnership{}

      iex> get_book_ownership!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book_ownership!(id), do: Repo.get!(BookOwnership, id)

  @doc """
  Creates a book_ownership.

  ## Examples

      iex> create_book_ownership(%{field: value})
      {:ok, %BookOwnership{}}

      iex> create_book_ownership(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book_ownership(attrs \\ %{}) do
    %BookOwnership{}
    |> BookOwnership.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book_ownership.

  ## Examples

      iex> update_book_ownership(book_ownership, %{field: new_value})
      {:ok, %BookOwnership{}}

      iex> update_book_ownership(book_ownership, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book_ownership(%BookOwnership{} = book_ownership, attrs) do
    book_ownership
    |> BookOwnership.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BookOwnership.

  ## Examples

      iex> delete_book_ownership(book_ownership)
      {:ok, %BookOwnership{}}

      iex> delete_book_ownership(book_ownership)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book_ownership(%BookOwnership{} = book_ownership) do
    Repo.delete(book_ownership)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book_ownership changes.

  ## Examples

      iex> change_book_ownership(book_ownership)
      %Ecto.Changeset{source: %BookOwnership{}}

  """
  def change_book_ownership(%BookOwnership{} = book_ownership) do
    BookOwnership.changeset(book_ownership, %{})
  end
end

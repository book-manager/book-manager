require IEx
defmodule BookerWeb.AuthorControllerTest do
  @moduledoc """
  Author controller tests
  """
  use BookerWeb.ConnCase

  import Mox

  alias Booker.Auth
  alias Booker.Auth.{Guardian, User}
  alias Booker.Authors
  alias Booker.Authors.{Author, Ownership}
  alias Booker.Books
  alias Booker.Repo

  alias Http.Mock

  alias Ecto.Changeset

  @user_attrs %{
    avatar_url: "some avatar_url",
    email: "james@gmail.com",
    is_admin: true,
    name: "James",
    password: "password",
    surname: "Bond"
  }

  @author_attrs %{
    avatar_url: "some avatar_url",
    name: "Robin",
    surname: "Cook",
    description: "asdasdasda",
    birth_date: ~N[2000-01-01 23:00:07]
  }

  setup %{conn: conn} do
    {:ok, user} = Auth.create_user(@user_attrs)
    {:ok, token, _} = Guardian.encode_and_sign(user, %{}, token_type: "access")

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{token}")
      |> assign(:current_user, user)

    {:ok, conn: conn}
  end

  describe "index/2" do
    test "when there are no authors", %{conn: conn} do
      response =
        conn
        |> get(author_path(conn, :index))
        |> json_response(200)

      assert response["data"] == []
    end

    test "when there are some authors owned by user", %{conn: conn} do
      create_author(@author_attrs)

      response =
        conn
        |> get(author_path(conn, :index))
        |> json_response(200)

      assert response["data"] != []
      assert length(response["data"]) == 1
    end
  end

  describe "create/2" do
    test "when there is no author in database", %{conn: conn} do
      response =
        conn
        |> post(author_path(conn, :create), %{author: @author_attrs})
        |> json_response(201)

      author = Repo.get_by!(Author, name: "Robin")

      assert author.surname == response["surname"]
      assert author.avatar_url == response["avatar_url"]
      assert author.description == response["description"]

      user = Repo.get_by!(User, name: "James") |> Repo.preload(:authors)

      assert length(user.authors) != 0
      assert List.first(user.authors) == author
    end
    test "when there is author in database", %{conn: conn} do
      create_author(@author_attrs)

      response =
        conn
        |> post(author_path(conn, :create), %{author: @author_attrs})
        |> json_response(201)

      user = Repo.get_by!(User, name: "James") |> Repo.preload(:authors)

      assert length(user.authors) != 0

      ownership = Repo.get_by!(Ownership, user_id: user.id)
      assert ownership
    end
  end

  describe "show/2" do
    test "when author exists", %{conn: conn} do
      author = create_author(@author_attrs)
      book = create_books()

      expect(Mock, :post, fn _, _, _, _ ->
        {:ok, %HTTPoison.Response{status_code: 200, body: ""}}
      end)

      conn |> post(book_path(conn, :create), %{book: %{title: "Nano", isbn: "9788375109764", description: "asdasd", author_id: author.id, imgData: "asd", imageName: "asd"}})
      response =
        conn
        |> get(author_path(conn, :show, author.id))
        |> json_response(200)

      assert author.surname == response["surname"]
      assert author.avatar_url == response["avatar_url"]
      assert author.description == response["description"]
    end
  end

  describe "search/2" do
    test "with full name starting with capital letter"
    test "with full name starting with small letter"
    test "with full surname starting with capital letter"
    test "with full surname starting with normal letter"
  end

  defp create_author(author_attrs) do
    current_user = Repo.get_by!(User, name: "James") |> Repo.preload(:authors)

    {:ok, author} = Authors.create_author(author_attrs)
    authors = [author] ++ current_user.authors

    current_user
      |> Repo.preload(:authors)
      |> Changeset.change()
      |> Changeset.put_assoc(:authors, authors)
      |> Repo.update!

    author
  end

  defp create_book(books_attrs) do
    book = Books.create_book(books_attrs)
  end
end

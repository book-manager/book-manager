require IEx

defmodule BookerWeb.UserControllerTest do
  @moduledoc """
  Test User controller
  """
  use BookerWeb.ConnCase

  alias Booker.Auth
  alias Booker.Auth.{Guardian, User}
  alias Booker.Repo

  @create_attrs %{
    avatar_url: "some avatar_url",
    email: "james@gmail.com",
    is_admin: true,
    name: "James",
    password: "password",
    surname: "Bond"
  }

  setup %{conn: conn} do
    {:ok, user} = Auth.create_user(@create_attrs)
    {:ok, token, _} = Guardian.encode_and_sign(user, %{}, token_type: "access")

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  describe "index/2" do
    test "when there is no JWT token" do
      response =
        build_conn()
        |> get(user_path(build_conn(), :index))

      assert response.status == 401
    end

    test "when there is only one User", %{conn: conn} do
      response =
        conn
        |> get(user_path(conn, :index))
        |> json_response(200)

      assert response["avatar_url"] == @create_attrs["avatar_url"]
      assert response["name"] == @create_attrs["name"]
      assert response["surname"] == @create_attrs["surname"]
      assert response["email"] == @create_attrs["email"]
    end

    test "when there are 2 Users", %{conn: conn} do
      Auth.create_user(%{
        avatar_url: "some avatar url",
        name: "name",
        surname: "surname",
        password: "password",
        email: "email"
      })

      response =
        conn
        |> get(user_path(conn, :index))
        |> json_response(200)

      assert length(response["data"]) == 2
    end
  end

  describe "login/2" do
    test "returns JWT token when given correct credentials" do
      response =
        build_conn()
        |> post(user_path(build_conn(), :login), %{email: "james@gmail.com", password: "password"})
        |> json_response(200)

      assert String.length(response["token"]) != 0
      assert response["user"]["name"] == @create_attrs.name
    end

    test "returns error when given incorrect credentials" do
      response =
        build_conn()
        |> post(user_path(build_conn(), :login), %{
          email: "james@gmail.com",
          password: "incorrect_password"
        })

      assert response.status == 401
    end
  end

  describe "search_user/2" do
    test "return User when given full name that starts with capital letter", %{conn: conn} do
      response =
        conn
        |> get(user_path(conn, :search_user, "James"))
        |> json_response(200)

      assert length(response["data"]) == 1
      user = List.first(response["data"])

      assert user["name"] == @create_attrs.name
      assert user["surname"] == @create_attrs.surname
      assert user["email"] == @create_attrs.email
    end

    test "return User when given full name that starts with normal letter", %{conn: conn} do
      response =
        conn
        |> get(user_path(conn, :search_user, "james"))
        |> json_response(200)

      assert length(response["data"]) == 1
      user = List.first(response["data"])

      assert user["name"] == @create_attrs.name
      assert user["surname"] == @create_attrs.surname
      assert user["email"] == @create_attrs.email
    end

    test "return User when given full surname that starts with capital letter", %{conn: conn} do
      response =
        conn
        |> get(user_path(conn, :search_user, "Bond"))
        |> json_response(200)

      assert length(response["data"]) == 1
      user = List.first(response["data"])

      assert user["name"] == @create_attrs.name
      assert user["surname"] == @create_attrs.surname
      assert user["email"] == @create_attrs.email
    end

    test "return User when given full surname that starts with normal letter", %{conn: conn} do
      response =
        conn
        |> get(user_path(conn, :search_user, "bond"))
        |> json_response(200)

      assert length(response["data"]) == 1
      user = List.first(response["data"])

      assert user["name"] == @create_attrs.name
      assert user["surname"] == @create_attrs.surname
      assert user["email"] == @create_attrs.email
    end
  end

  describe "show/2" do
    test "return User when given correct ID", %{conn: conn} do
      user = Repo.get_by(User, name: "James")

      response =
        conn
        |> get(user_path(conn, :show, user.id))
        |> json_response(200)

      assert response["name"] == @create_attrs.name
      assert response["surname"] == @create_attrs.surname
      assert response["email"] == @create_attrs.email
    end

    test "returns error when given incorrect ID", %{conn: conn} do
      response =
        conn
        |> get(user_path(build_conn(), :show, 2))

        assert response.status == 404
    end
  end

  describe "register/2" do
    @register_request %{email: "spider@gmail.com", name: "Peter", surname: "Parker", password: "password", cpassword: "password"}

    test "returns 200 when given correct data" do
      build_conn()
        |> post(user_path(build_conn(), :register), @register_request)
        |> json_response(201)

      user = Repo.get_by!(User, name: "Peter")

      assert user.name == @register_request.name
      assert user.surname == @register_request.surname
    end

    test "returns error when creating user with same email" do
      response =
        build_conn()
          |> post(user_path(build_conn(), :register), %{name: "James", surname: "Bond", email: "james@gmail.com", password: "password", cpassword: "password"})

      assert response.status == 409
    end

    test "returns error when given incorrect data" do
      response =
        build_conn()
          |> post(user_path(build_conn(), :register), %{name: "James", surname: "Bond", email: "james@gmail.com", password: "password", cpassword: "incorrect_password"})

      assert response.status == 422
    end
  end
end

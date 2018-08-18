require Logger
defmodule Booker.Auth.ErrorHandler do
  @moduledoc """
  Provides error handling for Auth module.
  We try to handle all authentication and authorization error here, providing meaningfull error messages for frontend applciation
  """
  import Plug.Conn

  use BookerWeb, :view

  def auth_error(conn, {:unathenticated, _reason}, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, "Unathenticated, please login first")
  end

  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    case body do
      "invalid_token" ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Poison.encode!(%{message: "asd"}))
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, body)
    end
  end
end

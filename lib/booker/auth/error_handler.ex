defmodule Booker.Auth.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {:unathenticated, _reason}, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, "Unathenticated, please login first")
  end


  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end

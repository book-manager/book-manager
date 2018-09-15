defmodule Booker.Auth.Plug.CurrentUser do
  @moduledoc """
  Insert current user into connection
  """
  import Plug.Conn
  alias Booker.Auth.Guardian

  def init(opts), do: opts

  def call(conn, _opts) do
    token = conn |> Guardian.Plug.current_token

    case Guardian.resource_from_token(token) do
      {:ok, %Booker.Auth.User{} = user, _} ->
        assign(conn, :current_user, user)
      {:error, _} ->
        conn |> halt
    end
  end
end

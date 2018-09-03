require Logger
defmodule BookerWeb.Context do
  @moduledoc """
  This module checks incoming requests for valid JWT token
  """
  @behaviour Plug

  import Plug.Conn

  alias Absinthe.Plug
  alias Booker.Auth.Guardian

  def init(opts), do: opts

  def call(conn, _) do
    Logger.info("Context has been invoked")
    context = build_context conn
    Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, current_user, _claims} <- Guardian.resource_from_token(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end
end

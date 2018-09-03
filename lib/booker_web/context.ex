defmodule BookerWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Booker.Accounts.User
  alias Booker.Repo

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context conn
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  REturn the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, current_user} <- authorize(token) do
      %{current_user: current_user}
    else
      _ -> %{}
    end
  end

  def authorize(token) do
    {:ok, user, _claims} = Booker.Auth.Guardian.resource_from_token(token)
    user
  end
end

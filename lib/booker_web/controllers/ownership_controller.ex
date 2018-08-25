defmodule BookerWeb.OwnershipController do
  use BookerWeb, :controller

  alias Booker.Authors
  alias Booker.Authors.Ownership

  action_fallback BookerWeb.FallbackController

  def index(conn, _params) do
    ownership = Author.list_ownership()
    render(conn, "index.json", ownership: ownership)
  end

  def create(conn, %{"ownership" => ownership_params}) do
    with {:ok, %Ownership{} = ownership} <- Authors.create_ownership(ownership_params) do
      conn
      |> put_status(:created)
      |> render("show.json", ownership: ownership)
    end
  end

  def show(conn, %{"id" => id}) do
    ownership = Authors.get_ownership!(id)
    render(conn, "show.json", ownership: ownership)
  end

  def update(conn, %{"id" => id, "ownership" => ownership_params}) do
    ownership = Author.get_ownership!(id)

    with {:ok, %Ownership{} = ownership} <- Authors.update_ownership(ownership, ownership_params) do
      render(conn, "show.json", ownership: ownership)
    end
  end

  def delete(conn, %{"id" => id}) do
    ownership = Author.get_ownership!(id)
    with {:ok, %Ownership{}} <- Authors.delete_ownership(ownership) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule BookerWeb.OwnershipController do
  use BookerWeb, :controller

  alias Booker.Authors
  alias Booker.Authors.Ownership

  alias Booker.Repo
  alias Ecto.Changeset

  action_fallback BookerWeb.FallbackController

  def index(conn, _params) do
    ownership = Authors.list_ownership()
    render(conn, "index.json", ownership: ownership)
  end

  def create(conn, %{"author_id" => author_id}) do
    current_user = Repo.preload(conn.assigns.current_user, :authors)
    authors = [Authors.get_author!(author_id)] ++ current_user.authors

    current_user
      |> Repo.preload(:authors)
      |> Changeset.change()
      |> Changeset.put_assoc(:authors, authors)
      |> Repo.update!

      render(conn, "show.json", %{owned: true})
  end

  @doc """
  Check if current user owns given author

  REMEBER: ID means author ID not ownership ID
  """
  def show(conn, %{"id" => id}) do
    current_user_id = conn.assigns.current_user.id
    ownership = Repo.get_by(Ownership, author_id: id, user_id: current_user_id)

    case ownership do
      %Ownership{} ->
        render(conn, "show.json", %{owned: true})
      nil ->
        render(conn, "show.json", %{owned: false})
    end
  end

  def update(conn, %{"id" => id, "ownership" => ownership_params}) do
    ownership = Authors.get_ownership!(id)

    with {:ok, %Ownership{} = ownership} <- Authors.update_ownership(ownership, ownership_params) do
      render(conn, "show.json", ownership: ownership)
    end
  end

  def delete(conn, %{"id" => id}) do
    ownership = Authors.get_ownership!(id)
    with {:ok, %Ownership{}} <- Authors.delete_ownership(ownership) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule Booker.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Booker.Auth.User
  alias Comeonin.Bcrypt

  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :password, :string
    field :surname, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :surname, :avatar_url, :password, :is_admin])
    |> validate_required([:email, :name, :surname, :avatar_url, :password, :is_admin])
    |> put_pass_hash()
  end

  @doc false
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  @doc false
  defp put_pass_hash(changeset), do: changeset
end

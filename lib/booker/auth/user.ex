defmodule Booker.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Booker.Auth.User
  alias Booker.Authors.{Author, Ownership}
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password, :string
    field :name, :string
    field :surname, :string
    field :avatar_url, :string, default: ""
    field :is_admin, :boolean, default: false

    timestamps()

    many_to_many :authors, Author, join_through: Ownership
  end

  @required_fields [
    :email,
    :name,
    :surname,
    :password
  ]

  @doc false
  def changeset(%User{} = user, attrs) do
    user
      |> cast(attrs, [:email, :name, :surname, :avatar_url, :password, :is_admin, :inserted_at, :updated_at])
      |> validate_required(@required_fields)
      |> cast_assoc(:authors)
      |> put_pass_hash()
  end

  @doc false
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  @doc false
  defp put_pass_hash(changeset), do: changeset
end

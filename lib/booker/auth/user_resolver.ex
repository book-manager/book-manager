defmodule Booker.Auth.UserResolver do
  @moduledoc """
  Resolver for User entity
  """

  alias Booker.Auth
  alias Booker.Auth.Guardian

  def login(params, _resolution) do
    with {:ok, user} <- Auth.authenticate_user(params[:email], params[:password]),
         {:ok, token, _} <- Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {1, :days}) do
          {:ok, %{token: token, user: user}}
    end
  end

  def register(params, _resolution) do
    %{email: email, password: password, confirm_password: confirm_password, name: name, surname: surname} = params

    case password == confirm_password do
      true ->
        Auth.create_user(%{email: email, password: password, name: name, surname: surname})
        {:ok, %{status: "Created"}}
      false ->
        {:error, "Cannot create user, please try again"}
    end
  end
end

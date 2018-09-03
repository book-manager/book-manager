defmodule Booker.Auth.Schema do
  @moduledoc """
  Schema for authorization operations
  """
  use Absinthe.Schema

  alias Booker.Auth.UserResolver

  import_types BookerWeb.Schema.Types

  query do

  end

  mutation do
    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &UserResolver.login/2
    end

    field :register, type: :register do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :confirm_password, non_null(:string)
      arg :name, non_null(:string)
      arg :surname, non_null(:string)

      resolve &UserResolver.register/2
    end
  end

end

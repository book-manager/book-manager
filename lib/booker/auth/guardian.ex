defmodule Booker.Auth.Guardian do
  use Guardian, otp_app: :booker
  alias Booker.Auth

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    case Auth.get_user!(claims["sub"]) do
      {:error, :not_found} -> {:error, :unathorized}
      resource -> {:ok, resource}
    end
  end
end

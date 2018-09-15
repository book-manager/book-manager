defmodule Booker.Auth.Pipeline do
  @moduledoc """
  Which Plug modules should we apply on incoming connection
  """
  use Guardian.Plug.Pipeline,
    otp_app: :booker,
    error_handler: Booker.Auth.ErrorHandler,
    module: Booker.Auth.Guardian

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Booker.Auth.Plug.CurrentUser
end

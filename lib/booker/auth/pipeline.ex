defmodule Booker.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :booker,
    error_handler: Booker.Auth.ErrorHandler,
    module: Booker.Auth.Guardian

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Booker.Auth.CurrentUser
end

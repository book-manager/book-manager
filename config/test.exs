use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :booker, BookerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :booker, Booker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "booker_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :booker, Booker.Auth.Guardian,
  issuer: "booker", # Name of your app/company/product
  secret_key: "test" # Replace this with the output of the mix command

config :booker,
  http_adapter: Http.Mock

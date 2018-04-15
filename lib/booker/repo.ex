defmodule Booker.Repo do
  use Ecto.Repo, otp_app: :booker

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def execute_and_load(sql, params, model) do
    result = query!(sql, params)
    Enum.map(result.rows, &load(model, {result.columns, &1}))
  end
end

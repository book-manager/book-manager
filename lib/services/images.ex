defmodule Services.Images do
  @moduledoc """
  Service for images service
  """
  alias Utils.HTTP

  @images_service_url Application.get_env(:booker, :images_service)

  def upload_user_avatar(data, image) do

  end

  @spec upload_author_avatar(String.t(), String.t())
    :: {:error, any()} | {:ok, false | nil | true | binary() | [any()] | number() | map()}
  def upload_author_avatar(name, image) do
    HTTP.post(@images_service_url <> "/api/author", %{name: name, image: image}, [])
  end

  def upload_book_cover(data, image) do
    HTTP.post(@images_service_url <> "/api/book/cover", data, [])
  end
end

defmodule ImageApiWeb.ImageController do
  use ImageApiWeb, :controller
  alias ImageApi.Images

  def validate(conn, %{"image_url" => image_url}) do
    response =
      case Images.validate_image(image_url) do
        {:ok, metadata} -> %{valid: true, metadata: metadata}
        {:error, reason} -> %{valid: false, reason: reason}
      end

    conn |> json(response)
  end

  def resize(conn, %{"image_url" => image_url} = params) do
    case Images.resize_image(params) do
      {:ok, resized_image_url} ->
        conn |> json(%{download_url: resized_image_url})

      {:error, reason} ->
        conn |> put_status(:unprocessable_entity) |> json(%{error: reason})
    end
  end
end

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
end

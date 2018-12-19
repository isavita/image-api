defmodule ImageApi.Images do
  @moduledoc """
  Provides functunality for processing images.
  """

  @image_manipulation_api Application.get_env(:image_api, :image_manipulation_api)
  @image_store Application.get_env(:image_api, :image_store)

  @doc """
  Returns {:ok, metadata} if the image is valid.

  Returns {:error, reason} if the image is not valid.
  """
  @spec validate_image(String.t()) :: {:ok, map()} | {:error, String.t()}
  def validate_image(image_url) do
    with {:ok, image_path} <- download_image(image_url),
         {:ok, image_info} <- get_image_validation_info(image_path),
         {:ok, _image_paths} <- remove_image(image_path) do
      {:ok, image_info}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_image_validation_info(image_path) do
    @image_manipulation_api.get_image_info(image_path)
  end

  defp download_image(image_url) do
    @image_store.download_image(image_url)
  end

  defp remove_image(image_path) do
    @image_store.remove_image(image_path)
  end
end

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
         {:ok, image_info} <- get_image_info(image_path),
         {:ok, _image_paths} <- remove_image(image_path) do
      {:ok, image_info}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Returns {:ok, resized_image_url} if the image was successfully resized.

  Returns {:error, reason} if the image couldn't be successfully resized.
  """
  def resize_image(params) do
    with {:ok, image_path} <- download_image(params["image_url"]),
         {:ok, resized_image_path} <- do_resize_image(image_path, params) do
      {:ok, resized_image_path}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_image_info(image_path) do
    @image_manipulation_api.get_image_info(image_path)
  end

  defp download_image(image_url) do
    @image_store.download_image(image_url)
  end

  defp remove_image(image_path) do
    @image_store.remove_image(image_path)
  end

  defp do_resize_image(image_path, params) do
    @image_manipulation_api.resize_image(image_path, params)
  end
end

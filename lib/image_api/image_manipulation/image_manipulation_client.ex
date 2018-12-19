defmodule ImageApi.ImageManipulation.ImageManipulationClient do
  @moduledoc """
  Adapter for integration with Image Magick using Mogrify library.
  """

  require Mogrify

  @doc "Gets image's metadata."
  @spec get_image_info(String.t()) :: {:ok, map} | {:error, String.t()}
  def get_image_info(path) do
    with {:ok, size} <- get_image_size(path),
         {:ok, image} <- do_get_image_info(path) do
      {:ok, image_info_to_map(image, size)}
    else
      error -> error
    end
  end

  defp image_info_to_map(image, size) do
    %{
      format: image.format,
      height: image.height,
      width: image.width,
      size: size
    }
  end

  defp do_get_image_info(path) do
    try do
      path |> Mogrify.open() |> Mogrify.verbose() |> (&{:ok, &1}).()
    rescue
      MatchError -> {:error, "file format is not supported"}
    end
  end

  defp get_image_size(path) do
    case File.stat(path) do
      {:ok, %{size: size}} -> {:ok, size}
      {:error, :enoent} -> {:error, "file does not exist"}
    end
  end
end

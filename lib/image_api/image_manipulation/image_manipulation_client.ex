defmodule ImageApi.ImageManipulation.ImageManipulationClient do
  @moduledoc """
  Adapter for integration with Image Magick using Mogrify library.
  """

  require Mogrify

  @doc "Gets image's metadata."
  @spec get_image_info(String.t()) :: {:ok, map()} | {:error, String.t() | atom()}
  def get_image_info(path) do
    with {:ok, size} <- get_image_size(path),
         {:ok, image} <- do_get_image_info(path) do
      {:ok, image_info_to_map(image, size)}
    else
      error -> error
    end
  end

  @doc "Resizes image to a given width or/and height."
  @spec resize_image(String.t(), map()) :: {:ok, map()} | {:error, String.t() | atom()}
  def resize_image(image_path, params) do
    with {:ok, width} <- number_or_nil(params["width"], "width"),
         {:ok, height} <- number_or_nil(params["height"], "height"),
         {:ok, image} <- do_resize_image(image_path, width, height) do
      {:ok, image.path}
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

  defp number_or_nil(value, _) when is_number(value) or is_nil(value), do: {:ok, value}
  defp number_or_nil(_, type), do: {:error, "#{type} have to be a number or to be skipped"}

  defp do_resize_image(_, nil, nil),
    do: {:error, "resizing an image requires width/height option"}

  defp do_resize_image(image_path, width, height) do
    image_path
    |> Mogrify.open()
    |> Mogrify.resize("#{width}x#{height}")
    |> Mogrify.save(in_place: true)
    |> (&{:ok, &1}).()
  end
end

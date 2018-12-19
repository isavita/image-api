defmodule ImageApi.ImageStore.ImageStoreClient do
  @moduledoc """
  Adapter for downloading images from a given url.
  """

  require Download

  @max_file_size 2 * 1024 * 1024
  @store_path "/tmp/images/"

  @doc "Downloads file from url if it is not more than 2MB."
  @spec download_image(String.t()) :: {:ok, String.t()} | {:error, String.t()} | no_return()
  def download_image(url) do
    case Download.from(url, path: image_path(url), max_file_size: @max_file_size) do
      {:ok, path} -> {:ok, path}
      {:error, reason} -> {:error, reason}
      _ -> {:error, "cannot process the image"}
    end
  end

  @doc "Removes the image and the directory in which the image is it."
  @spec remove_image(String.t()) :: {:ok, list()} | {:error, any(), any()}
  def remove_image(path) do
    path |> Path.dirname() |> File.rm_rf()
  end

  defp image_path(url) do
    path = directory_path()

    case create_directory_path(path) do
      :ok ->
        path <> extract_file_name(url)

      _ ->
        raise "cannot create a directory #{path}"
    end
  end

  defp create_directory_path(path) do
    File.mkdir_p(path)
  end

  defp directory_path do
    @store_path <> Ecto.UUID.generate() <> "/"
  end

  defp extract_file_name(url) do
    url |> URI.parse() |> Map.get(:path) |> Path.basename()
  end
end

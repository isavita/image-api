defmodule ImageApi.ImageStore.ImageStoreFake do
  @moduledoc """
  Fake adapter for test/development environment.
  """

  @success {:ok, "fake_path_to_a_file.jpg"}
  @failure {:error, "fake reason"}

  @doc false
  def download_image(url) do
    if String.contains?(url, "failure"), do: @failure, else: @success
  end

  @doc false
  def remove_image(path), do: {:ok, [path]}
end

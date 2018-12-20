defmodule ImageApi.ImageManipulation.ImageManipulationFake do
  @moduledoc """
  Fake adapter for test/development environment.
  """

  @doc false
  def get_image_info(_path) do
    {:ok,
     %{
       format: "jpeg",
       height: 350,
       size: 30_000,
       width: 600
     }}
  end

  @doc false
  def resize_image(_image_path, _params), do: {:ok, "fake_path.jpg"}
end

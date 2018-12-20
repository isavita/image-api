defmodule ImageApi.ImageManipulation.ImageManipulationClientTest do
  use ExUnit.Case
  alias ImageApi.ImageManipulation.ImageManipulationClient

  @test_image_path "test/fixtures/images/image1-100x150.jpg"

  describe "get_image_info/1" do
    setup do
      {:ok, %{path: @test_image_path}}
    end

    test "gets information for the size and format of an image when the image exists", %{
      path: path
    } do
      expected = {:ok, %{format: "jpeg", size: 12_451, width: 100, height: 150}}

      assert ImageManipulationClient.get_image_info(path) == expected
    end

    test "returns a format error when the file is not an image" do
      path = "test/fixtures/text.txt"

      assert ImageManipulationClient.get_image_info(path) ==
               {:error, "file format is not supported"}
    end

    test "returns a file error when the file does not exist" do
      assert ImageManipulationClient.get_image_info("does_not_exist.jpg") ==
               {:error, "file does not exist"}
    end
  end

  describe "resize_image/2" do
    setup do
      destination = "/tmp/random-named-image007.jpg"
      File.cp(@test_image_path, destination)
      params = %{"width" => 200, "height" => 300}

      on_exit(fn -> File.rm(destination) end)

      {:ok, path: destination, params: params}
    end

    test "resizes given image", %{path: path, params: params} do
      assert {:ok, path} = ImageManipulationClient.resize_image(path, params)
      assert {:ok, %{width: 200, height: 300}} = ImageManipulationClient.get_image_info(path)
    end
  end
end

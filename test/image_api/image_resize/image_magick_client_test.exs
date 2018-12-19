defmodule ImageApi.ImageResize.ImageMagickClientTest do
  use ExUnit.Case
  alias ImageApi.ImageResize.ImageMagickClient

  describe "get_image_info/1" do
    setup do
      {:ok, %{path: "test/fixtures/images/image1-100x150.jpg"}}
    end

    test "gets information for the size and format of an image when the image exists", %{
      path: path
    } do
      expected = {:ok, %{format: "jpeg", size: 12451, width: 100, height: 150}}

      assert ImageMagickClient.get_image_info(path) == expected
    end

    test "returns a format error when the file is not an image" do
      path = "test/fixtures/text.txt"

      assert {:error, "file format is not supported"} = ImageMagickClient.get_image_info(path)
    end

    test "returns a file error when the file does not exist" do
      assert {:error, "file does not exist"} =
               ImageMagickClient.get_image_info("does_not_exist.jpg")
    end
  end
end

defmodule ImageApi.ImagesTest do
  use ExUnit.Case
  alias ImageApi.Images

  describe "validate_image/1" do
    test "returns a metadata for the image if it was successfully processed and it is correct" do
      expected = {:ok, %{format: "jpeg", size: 30_000, width: 600, height: 350}}

      assert Images.validate_image("success.jpg") == expected
    end

    test "returns an error if the image wasn't successfully processed" do
      assert {:error, _} = Images.validate_image("failure.png")
    end
  end

  describe "resize_image/1" do
    test "returns path to the resized image if the image was successfully processed" do
      assert Images.resize_image(%{"image_url" => "success.png"}) == {:ok, "fake_path.jpg"}
    end

    test "returns an error if the image wasn't successfully processed" do
      assert {:error, _} = Images.resize_image(%{"image_url" => "failure.png"})
    end
  end
end

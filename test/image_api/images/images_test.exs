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
    setup do
      {:ok, params: %{"image_url" => "failure.png"}}
    end

    test "returns an error if the image wasn't successfully processed", %{params: params} do
      assert {:error, _} = Images.resize_image(params)
    end
  end
end

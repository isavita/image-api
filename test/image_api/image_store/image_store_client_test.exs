defmodule ImageApi.ImageStore.ImageStoreClientTest do
  use ExUnit.Case
  alias ImageApi.ImageStore.ImageStoreClient

  describe "download_image/1" do
    test "returns file too big error when the file is bigger than 2MB"
  end

  describe "remove_image/1" do
    test "removes the file and the directory in which an image is it"
  end
end

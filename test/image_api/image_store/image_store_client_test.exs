defmodule ImageApi.ImageStore.ImageStoreClientTest do
  use ExUnit.Case
  alias ImageApi.ImageStore.ImageStoreClient

  describe "download_image/1" do
    test "downloads the file when is smaller than or equal to 2MB" do
      url = "http://speedtest.ftp.otenet.gr/files/test100k.db"

      assert {:ok, path} = ImageStoreClient.download_image(url)

      ImageStoreClient.remove_image(path)
    end

    test "returns file too big error when the file is bigger than 2MB" do
      url = "http://speedtest.ftp.otenet.gr/files/test10Mb.db"
      expected = {:error, :file_size_is_too_big}

      assert ImageStoreClient.download_image(url) == expected
    end

    test "returns an error when the file cannod be downloaded" do
      url = "http://randomhost.com/does_not_exist_image.jpg"
      expected = {:error, "cannot process the image"}

      assert ImageStoreClient.download_image(url) == expected
    end
  end

  describe "remove_image/1" do
    setup do
      directory = "/tmp/random_folder"
      File.mkdir_p(directory)
      image_path = directory <> "/random.jpg"
      File.write!(image_path, "not real image")

      {:ok, directory: directory, image_path: image_path}
    end

    test "removes the file and the directory of the image", %{
      directory: directory,
      image_path: image_path
    } do
      expected = {:ok, [directory, image_path]}

      assert ImageStoreClient.remove_image(image_path) == expected

      refute File.exists?(image_path)
      refute File.exists?(directory)
    end
  end
end

defmodule ImageApiWeb.ImageControllerTest do
  use ImageApiWeb.ConnCase

  describe "validate/2" do
    test "responds with image metadata if given valid image", %{conn: conn} do
      response =
        conn
        |> post(Routes.image_path(conn, :validate), %{"image_url" => "success.jpg"})
        |> json_response(200)

      expected = %{
        "metadata" => %{
          "format" => "jpeg",
          "size" => 30_000,
          "height" => 350,
          "width" => 600
        },
        "valid" => true
      }

      assert response == expected
    end
  end

  describe "resize/2" do
    test "responds with url for downloading the resized image if given valid image", %{conn: conn} do
      response =
        conn
        |> post(Routes.image_path(conn, :resize), %{
          "image_url" => "success.jpg",
          "width" => 200,
          "height" => 100
        })
        |> json_response(200)

      expected = %{"download_url" => "fake_path.jpg"}

      assert response == expected
    end
  end
end

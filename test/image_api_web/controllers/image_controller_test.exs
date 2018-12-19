defmodule ImageApiWeb.ImageControllerTest do
  use ImageApiWeb.ConnCase

  describe "validate/2" do
    test "responds with image info if given valid image", %{conn: conn} do
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
end

defmodule Exdocker.ImagesTest do
  use ExUnit.Case, async: true

  alias Exdocker.Support.DockerTestUtils
  alias Exdocker.Images

  @test_image "dallagi/empty"
  @test_tag "3.0"
  @another_tag "2.0"

  describe "pull" do
    setup do
      for tag <- ["latest", @test_tag, @another_tag],
          do: DockerTestUtils.remove_image(@test_image <> ":" <> tag)

      :ok
    end

    test "pulls the image at the desired tag" do
      :ok = Images.pull(@test_image, @test_tag)
      assert DockerTestUtils.image_exists?(@test_image <> ":" <> @test_tag)
      refute DockerTestUtils.image_exists?(@test_image <> ":" <> @another_tag)
    end

    test "pulls latest tag by default" do
      :ok = Images.pull(@test_image)
      assert DockerTestUtils.image_exists?(@test_image <> ":latest")
      refute DockerTestUtils.image_exists?(@test_image <> ":" <> @another_tag)
    end

    test "pulls all tags when given tag :all" do
      :ok = Images.pull(@test_image, :all)
      assert DockerTestUtils.image_exists?(@test_image <> ":latest")
      assert DockerTestUtils.image_exists?(@test_image <> ":" <> @test_tag)
      assert DockerTestUtils.image_exists?(@test_image <> ":" <> @another_tag)
    end
  end
end

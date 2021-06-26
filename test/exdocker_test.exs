defmodule ExdockerTest do
  use ExUnit.Case, async: true

  alias Exdocker.Support.DockerTestUtils

  @test_image "dallagi/empty:1.0"

  describe "stream_events" do
    test "stream_events streams docker events" do
      {:ok, stream_ref} = Exdocker.stream_events()

      DockerTestUtils.pull_image!(@test_image)

      assert_receive {:event, ^stream_ref,
                      %{
                        "Type" => "image",
                        "Action" => "pull",
                        "Actor" => %{"Attributes" => %{"name" => "dallagi/empty"}, "ID" => "dallagi/empty:1.0"},
                        "id" => "dallagi/empty:1.0",
                        "time" => _time
                      }}
    end

    test "can filter specific events only" do
      {:ok, stream_ref} = Exdocker.stream_events(filters: %{type: ["image"]})

      DockerTestUtils.pull_image!(@test_image)
      DockerTestUtils.create_container!(@test_image, ["sh"])

      assert_receive {:event, ^stream_ref, %{"Type" => "image"}}
      refute_receive {:event, ^stream_ref, %{"Type" => "container"}}
    end

    test "can filter by time" do
      DockerTestUtils.pull_image!(@test_image)
      one_minute_ago = DateTime.now!("Etc/UTC") |> DateTime.add(-10 * 60)

      {:ok, stream_ref} = Exdocker.stream_events(since: one_minute_ago)

      assert_receive {:event, ^stream_ref,
                      %{
                        "Type" => "image",
                        "Action" => "pull",
                        "Actor" => %{"Attributes" => %{"name" => "dallagi/empty"}, "ID" => "dallagi/empty:1.0"},
                        "id" => "dallagi/empty:1.0",
                        "time" => _time
                      }}
    end
  end
end

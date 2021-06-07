defmodule Excontainers.Support.TestUtils do
  def random_string(length \\ 16) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode32()
    |> binary_part(0, length)
  end
end
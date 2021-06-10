defmodule Excontainers.Utils.ExtraEnum do
  @spec remove_nils(Enum.t()) :: map()
  def remove_nils(enum) do
    enum
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end

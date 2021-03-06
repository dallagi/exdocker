defmodule Exdocker.Utils.ExtraKeyword do
  @moduledoc false

  @spec take_values(Keyword.t(), list()) :: list()
  def take_values(keyword, keys) do
    for key <- keys, do: Keyword.get(keyword, key)
  end
end

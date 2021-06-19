defmodule Exdocker.Utils.Logs do
  @std_streams_by_id %{0 => :stdin, 1 => :stdout, 2 => :stderr}
  @type std_stream :: :stdout | :stderr | :stdin
  @type log_chunk :: {std_stream(), String.t()}

  @spec parse_and_forward(pid()) :: :ok
  def parse_and_forward(forward_to) do
    receive do
      {:chunk, ref, chunk} ->
        for {stream, text} <- parse_chunk(chunk) do
          send(forward_to, {:log_chunk, ref, stream, text})
        end

        parse_and_forward(forward_to)

      {:end, ref} ->
        send(forward_to, {:log_end, ref})
        :ok
    end
  end

  @spec parse_chunk(binary()) :: [log_chunk()]
  def parse_chunk(<<>>), do: []

  def parse_chunk(chunk) do
    <<stream_id, 0, 0, 0, size::32, text::binary-size(size), rest::binary>> = chunk
    stream = Map.fetch!(@std_streams_by_id, stream_id)

    [{stream, text} | parse_chunk(rest)]
  end
end

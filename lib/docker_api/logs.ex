defmodule Excontainers.DockerApi.Logs do
  @std_streams_by_id %{0 => :stdin, 1 => :stdout, 2 => :stderr}

  def parse_and_forward(forward_to) do
    receive do
      {:chunk, ref, chunk} ->
        for {stream, text} <- parse_chunk(chunk) do
          send(forward_to, {:log_chunk, ref, stream, text})
        end

        parse_and_forward(forward_to)

      {:end, ref} ->
        send(forward_to, {:log_end, ref})
    end
  end

  def parse_chunk(<<>>), do: []

  def parse_chunk(chunk) do
    <<stream_id, 0, 0, 0, size::32, text::binary-size(size), rest::binary>> = chunk
    stream = Map.fetch!(@std_streams_by_id, stream_id)

    [{stream, text} | parse_chunk(rest)]
  end
end

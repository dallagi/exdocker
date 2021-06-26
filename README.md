# Exdocker

![CircleCI](https://img.shields.io/circleci/build/github/dallagi/exdocker)
![Coveralls](https://img.shields.io/coveralls/github/dallagi/exdocker)
![Hex.pm](https://img.shields.io/hexpm/v/exdocker)

Elixir client for the Docker Engine API.

Currently focused mostly on what is needed for [Excontainers](https://github.com/dallagi/excontainers), contributions to add other functionalities are very welcome :)

## Purpose

This project aims to provide a easy way to interface with the Docker Engine API, taking care of matters such as running requests, registry authentication (WIP), and parsing and streaming logs.

`exdocker` follows the APIs exposed by Docker closely, hence some operations may not feel very ergonomic compared to eg. the Docker CLI.
For a higher-level abstraction for working with Docker, follow [Excontainers](https://github.com/dallagi/excontainers).

The highest priority is to support functionalities necessary for `excontainers`.
Support for other functionalities is also a goal and any contribution for that is very welcome.
Support for Swarm APIs is not a goal.

## Installation

The package can be installed
by adding `exdocker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exdocker, "~> 0.1.0"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/exdocker](https://hexdocs.pm/exdocker).

## Quickstart

By default, requests are run on the default docker host of the system, as specified by the `DOCKER_HOST` environment variable and defaulting on `/var/run/docker.sock`:

```elixir
:ok = Exdocker.Images.pull("alpine", "latest")
```

To run requests on a different docker host, a `context` can be passed to any function wrapping a Docker API:

```elixir
context = %Exdocker.Context{host: "tcp://192.168.59.103:1234", api_version: "v1.41"}
:ok = Exdocker.Images.pull("alpine", "latest", context: context)
```

Some operations can stream output as messages:

```elixir
{:ok, ref} = Exdocker.Containers.stream_logs("container-id", stdout: true, stderr: true, stream_to: self())

receive do
  {:log_chunk, ^ref, :stdout, text} -> IO.puts("Received #{text} on stdout")
  {:log_chunk, ^ref, :stderr, text} -> IO.puts("Received #{text} on stderr")
  {:log_end, ^ref} -> IO.puts("Container stopped")
end
```

defmodule Exdocker.MixProject do
  use Mix.Project

  def project do
    [
      app: :exdocker,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Exdocker.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:finch, "~> 0.13.0"},
      {:jason, "~> 1.4"},
      {:yaml_elixir, "~> 2.9.0", only: [:dev, :test]}
    ]
  end
end

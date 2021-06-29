defmodule MnesiaManager.MixProject do
  use Mix.Project

  def project do
    [
      app: :mnesia_manager,
      version: "0.1.0",
      elixir: "~> 1.11",
      config_path: "config/config.exs",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {MnesiaManager.Application, []},
      extra_applications: [:logger, :mnesia]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 3.3"}
    ]
  end
end

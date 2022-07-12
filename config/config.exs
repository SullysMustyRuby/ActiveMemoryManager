use Mix.Config

config :libcluster,
  topologies: [
    localhost: [
      strategy: Cluster.Strategy.LocalEpmd
    ]
  ]

config :mnesia,
  dir: '.mnesia/#{String.to_atom(System.get_env("MNESIA_MANAGER") || "mnesia_manager@localhost")}'

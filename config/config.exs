use Mix.Config

config :libcluster,
  topologies: [
    localhost: [
      strategy: Cluster.Strategy.LocalEpmd
      # config: [
      #   hosts: [
      #     String.to_atom(System.get_env("CORE_SERVER") || "core_server@localhost")
      #   ]
      # ]
    ]
  ]

config :mnesia,
  dir: '.mnesia/#{String.to_atom(System.get_env("MNESIA_MANAGER") || "mnesia_manager@localhost")}'

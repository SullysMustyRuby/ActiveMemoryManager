use Mix.Config

config :libcluster,
  topologies: [
    localhost: [
      strategy: Cluster.Strategy.LocalEpmd,
      config: [
        hosts: [
          String.to_atom(System.get_env("HUBSYNCHTWO_NODE_NAME") || "hub_bridge@localhost")
        ]
      ]
    ]
  ]

config :mnesia,
  dir: '.mnesia/#{String.to_atom(System.get_env("MNESIA_MANAGER") || "mnesia_manager@localhost")}'

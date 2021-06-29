use Mix.Config

config :libcluster,
  topologies: [
    localhost: [
      strategy: Cluster.Strategy.LocalEpmd,
      config: [
        hosts: [
          String.to_atom(System.get_env("HUBSYNCHTWO_NODE_NAME") || "hubsynch_two@localhost")
        ]
      ]
    ]
  ]

config :mnesia,
  dir: '.mnesia/#{node()}'

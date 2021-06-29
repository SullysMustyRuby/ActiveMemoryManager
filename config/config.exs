use Mix.Config

config :libcluster,
  topologies: [
    localhost: [
      strategy: Cluster.Strategy.LocalEpmd,
      config: [
        hosts: [
          :hubsynch_two@localhost
        ]
      ]
    ]
  ]

config :mnesia,
  dir: '.mnesia/#{node()}'

import Config

config :libcluster,
  topologies: [
    localhost: [
      strategy: Cluster.Strategy.LocalEpmd,
      config: [
        hosts: [:demo1@localhost, :demo2@localhost, :demo3@localhost]
      ]
    ]
  ]

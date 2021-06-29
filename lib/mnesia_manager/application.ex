defmodule MnesiaManager.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor,
       [Application.get_env(:libcluster, :topologies), [name: MnesiaManager.ClusterSupervisor]]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MnesiaManager.Supervisor)
  end
end

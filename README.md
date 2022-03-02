# MnesiaManager
Designed to backup [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) :mnesia databases. 
Allows for  HubsynchTwo service stops and starts and will persist data.
This service also saves in disk copies, thus this service can also stop and start and data will persist.

## Prerequisites
* Elixir at least version 1.11.2 with Erlang/OTP 23 ([suggest ASDF](https://asdf-vm.com/))
* Gcc ([Homebrew](https://formulae.brew.sh/formula/gcc#default))
* Xcode (for mac) 

## Installation
This is a very small and basic service thus:
```bash
mix deps.get
``` 
Is all you need.

## Use
Before running [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) and [HubVault](https://github.com/ErinHivelociy/hub-vault)
Start this service with:
```bash
iex --sname mnesia_manager@localhost -S mix
```

### First time starting this app
Once the service is running in iex terminal run following command:
```elixir
iex> MnesiaManager.create_schema()
```
Start the [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) and [HubVault](https://github.com/ErinHivelociy/hub-vault)
following the README instructions at those repositories 

#### Potential failure notice
If you recieve an 
```elixir
{:error, {:not_active, SomeModuleName, :mnesia_manager@localhost}}
```
Or something similiar that is a sign Mnesia needs to recreate the schema with all the nodes attached. Mnesia has a strange schema creation and requires all the nodes which require disk persistance to be attached (even though that actual disk persistance is on MnesiaManager).

Once all the nodes are connected, you need to stop Mnesia on all the nodes, delete any old schemas with
```elixir
:mnesia.stop
:mnesia.delete_schema
```

Then on the MnesiaManager node only create the schema:
```elixir
:mnesia.create_schema([node() | Node.list()])
```

Then restart :mnesia on all nodes.

## Production deployment
Currently using Elixir 1.11.2 (compiled with Erlang/OTP 23)
For production deployment run these commands in a Linux or Mac machine with Elixir and Erlang installed.
Ensure you have the environmental variables installed.

- set -a; source .env.prod;
- git pull
- mix release
- _build/prod/rel/mnesia_manager/bin/mnesia_manager start

### To connect to remotely to a running server
_build/prod/rel/mnesia_manager/bin/mnesia_manager remote

### Server Environment
Application is currently running as a service with systemctl, the file is located at /etc/systemd/system/mnesia_manager.service
- Check the status: systemctl status mnesia_manager.service
- Restart: sudo systemctl restart mnesia_manager.service
- Stop: sudo systemctl stop mnesia_manager.service
- Start: sudo systemctl start mnesia_manager.service
- Check logs: journalctl -u mnesia_manager.service | tail -50

## Maintenence and Support tips

### Removing stopped db nodes 

1. Delete the tables belonging to the node. Must use the full table name.
Example:
```elixir
:mnesia.delete_table(MetricsServer.Secrets)
```
If there is an error about majority or nodes down change the majority for that table. This allows changes like deletes to happen when nodes are down.
Example:
```elixir
:mnesia.change_table_majority(MetricsServer.Secrets, false)
```
2. Delete the node schema. Must use quotes around the string when the node has an ip address in the name.
Example:
```elixir
:mnesia.delete_schema(:"metrics_server@ip-10-11-198")
```
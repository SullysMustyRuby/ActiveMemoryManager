# MnesiaManager
Designed to backup [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) :mnesia databases. 
Allows for  HubsynchTwo service stops and starts and will persist data.
This service also saves in disk copies, thus this service can also stop and start and data will persist.

## Installation
This is a very small and basic service thus:
`mix deps.get` 
Is all you need.

## Use
Before running [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) and [HubVault](https://github.com/ErinHivelociy/hub-vault)
Start this service with:
`iex --sname mnesia_manager@localhost -S mix`

### First time starting this app
Once the service is runnint in iex terminal run following command:
```elixir
MnesiaManager.create_schema()
```
Start the [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) and [HubVault](https://github.com/ErinHivelociy/hub-vault)
following the README instructions at those repositories 

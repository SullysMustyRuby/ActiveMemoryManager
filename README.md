# MnesiaManager
Designed to backup [HubsynchTwo](https://github.com/ErinHivelociy/hubsynch_two) :mnesia databases. 
Allows for  HubsynchTwo service stops and starts and will persist data.
This service also saves in disk copies, thus this service can also stop and start and data will persist.

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

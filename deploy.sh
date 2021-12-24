#!/bin/bash

# Path variables
mnesia_manager_path="/home/ec2-user/mnesia-manager/"
mnesia_manager_backup_path="/home/ec2-user/release-backups/mnesia-manager/"
mnesia_manager_build_path="/home/ec2-user/mnesia-manager/_build/prod/rel/mnesia_manager/"
mnesia_manager_env="/home/ec2-user/mnesia-manager/.env.prod"
mnesia_manager_service_path="/home/ec2-user/mnesia-manager/_build/prod/rel/mnesia_manager/bin/mnesia_manager"

# Functions
backup_release() {
  cp -Rf $mnesia_manager_build_path $mnesia_manager_backup_path
}

check_heartbeats() {
  status=$($mnesia_manager_service_path rpc "Elixir.MnesiaManager.heartbeat")
  if [[ $status != "ok" ]]; then
    return 1
  fi

  echo $1
  exit $2
}

ore_release() {
  cp -Rf $mnesia_manager_backup_path $mnesia_manager_build_path
  sudo systemctl restart mnesia_manager.service
}

# Go into hubsynch_to dir
cd $mnesia_manager_path

# git dance
git checkout main
git pull

# Set env from .env file
set -o allexport; source $mnesia_manager_env; set +o allexport

# Get dependancies
mix deps.get

# Backup the working release in case of rollback
echo "backing up current release"
backup_release

# Build new release
mix release --overwrite --quiet

# Restart service with new release
echo "starting new release"
sudo systemctl restart mnesia_manager.service

sleep 10s

echo "checking heartbeats"
check_heartbeats "First heartbeat check all functional" 0

sleep 10s

check_heartbeats "Second heartbeat check all functional" 0

echo "heartbeats failed restoring old release"
restore_release

sleep 10s

check_heartbeats "Restored release successfully" 1

echo "Deploy and Restore both failed"
exit 2

#!/usr/bin/env bash

NETWORK_NAME="shared"

# Check if the network exists
if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  echo "Network '$NETWORK_NAME' not found. Creating..."
  docker network create "$NETWORK_NAME"
  echo "Network '$NETWORK_NAME' created."
else
  echo "Network '$NETWORK_NAME' already exists."
fi

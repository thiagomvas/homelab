#!/usr/bin/env bash

NETWORK_NAME="shared"
CERT_DIR=~/traefik-test/certs
CERT_FILE="$CERT_DIR/thiagomvas.dev.crt"
KEY_FILE="$CERT_DIR/thiagomvas.dev.key"

# Check if the network exists
if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  echo "Network '$NETWORK_NAME' not found. Creating..."
  docker network create "$NETWORK_NAME"
  echo "Network '$NETWORK_NAME' created."
else
  echo "Network '$NETWORK_NAME' already exists."
fi

# Create certs only if they don't exist
if [[ -f "$CERT_FILE" && -f "$KEY_FILE" ]]; then
  echo "SSL certificate and key already exist. Skipping creation."
else
  echo "Generating self-signed SSL certificate..."
  mkdir -p "$CERT_DIR"
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -subj "/CN=*.thiagomvas.dev" \
    -addext "subjectAltName=DNS:*.thiagomvas.dev,DNS:thiagomvas.dev"
  echo "SSL certificate and key created."
fi

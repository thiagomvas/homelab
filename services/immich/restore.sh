#!/bin/bash
set -euo pipefail

# Load .env
ENV_FILE="/home/tmv-cloud/homelab/services/immich/.env"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

# Absolute paths
BASE_DIR="/home/tmv-cloud/homelab/services/immich"
BACKUP_DIR="/home/tmv-cloud/homelab/backups/immich"
DATA_DIR="$(realpath "$BASE_DIR/$UPLOAD_LOCATION/")"

DOCKER=/usr/bin/docker
TAR=/bin/tar
GUNZIP=/bin/gunzip

# Filenames
DB_BACKUP="$BACKUP_DIR/dump.sql.gz"
DATA_BACKUP="$BACKUP_DIR/immich_data.tar.gz"

echo "[$(date)] Stopping Immich containers and removing volumes..."
docker compose down -v

# Optional: reset Postgres data folder if needed
# echo "[$(date)] Resetting Postgres data folder..."
# rm -rf "$BASE_DIR/postgres-data"

echo "[$(date)] Starting Postgres..."
docker compose create
docker start immich_postgres
sleep 10

echo "[$(date)] Restoring database..."
$GUNZIP --stdout "$DB_BACKUP" \
| sed "s/SELECT pg_catalog.set_config('search_path', '', false);/SELECT pg_catalog.set_config('search_path', 'public, pg_catalog', true);/g" \
| docker exec -i immich_postgres psql --dbname=postgres --username="$DB_USERNAME"

echo "[$(date)] Restoring media files..."
mkdir -p "$DATA_DIR"
$TAR -xzf "$DATA_BACKUP" -C "$DATA_DIR"

echo "[$(date)] Starting all Immich containers..."
docker compose up -d

echo "[$(date)] Restore completed."

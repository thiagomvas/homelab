#!/usr/bin/env bash

clear

cat <<'EOF'
  __  .__    .__                                             .__                          .__        ___.    
_/  |_|  |__ |__|____     ____   ____   ________  __         |  |__   ____   _____   ____ |  | _____ \_ |__  
\   __\  |  \|  \__  \   / ___\ /  _ \ /     \  \/ /  ______ |  |  \ /  _ \ /     \_/ __ \|  | \__  \ | __ \ 
 |  | |   Y  \  |/ __ \_/ /_/  >  <_> )  Y Y  \   /  /_____/ |   Y  (  <_> )  Y Y  \  ___/|  |__/ __ \| \_\ \
 |__| |___|  /__(____  /\___  / \____/|__|_|  /\_/           |___|  /\____/|__|_|  /\___  >____(____  /___  /
           \/        \//_____/              \/                    \/             \/     \/          \/    \/ 
EOF

export HOST_IP=192.168.100.130

echo ""
echo "=== Starting infrastructure ==="
bash "infra/pre-start.sh"
docker compose -f infra/docker-compose.yml up -d

echo ""
echo "=== Starting services ==="
SERVICES_DIR="services"

for dir in "$SERVICES_DIR"/*/; do
  if [ -f "$dir/pre-start.sh" ]; then
    echo "> running pre-start.sh in $dir"
    bash "$dir/pre-start.sh"
  fi

  if [ -f "$dir/docker-compose.yml" ]; then
    echo "> $dir"
    docker compose -f "$dir/docker-compose.yml" up -d
  else
    echo "> $dir (skipped – no docker-compose.yml)"
  fi
done

echo ""
echo "All services started."

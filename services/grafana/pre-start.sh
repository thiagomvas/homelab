#!/bin/bash

server_url="grafana.thiagomvas.dev"

find . -type f -exec sed -i "s/grafana.thiagomvas.dev/${server_url}/g" {} +

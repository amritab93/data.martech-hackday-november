#!/bin/bash
set -e

STATE=NOT_RUNNING

curl -X POST -H "Content-Type: application/json" --data @connectors/postgres.json ${KAFKA_CONNECT_URL}/connectors

STATE=$(docker-compose -f ./docker-compose.yml exec -T kafka-connect curl -X GET -H "Content-Type: application/json" "$KAFKA_CONNECT_URL"/connectors/"$NAME"/status | jq -r '.tasks[0].state')
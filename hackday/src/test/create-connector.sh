#!/bin/bash
set -e

STATE=NOT_RUNNING

CONNECTOR_CONFIG=../connectors/postgres.json

curl -X POST -H "Content-Type: application/json" --data @test/connectors/postgres.json ${KAFKA_CONNECT_URL}/connectors

STATE=$(docker-compose -f ./docker-compose.yml exec -T kafka-connect curl -X GET -H "Content-Type: application/json" "$KAFKA_CONNECT_URL"/connectors/"$NAME"/status | jq -r '.tasks[0].state')
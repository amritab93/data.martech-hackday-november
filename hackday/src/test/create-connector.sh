#!/bin/bash
set -e

STATE="NOT_RUNNING"

curl -X POST -H "Content-Type: application/json" --data @connectors/postgres.json "${KAFKA_CONNECT_URL}"/connectors
#wait until the connector is initialized
sleep 5

STATE=$(curl -X GET -H "Content-Type: application/json" "${KAFKA_CONNECT_URL}"/connectors/testPostgresConnector/status | jq -r '.tasks[0].state')

if [ "${STATE}" == "RUNNING" ]
then
  echo "Connector is running, all good."
else
  echo "Something went wrong with the connector, it is not running."
  exit 1
fi
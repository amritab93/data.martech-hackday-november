#!/bin/bash
set -e

EXPECTED_COUNT=2

ACTUAL_COUNT=$(docker exec -it datamartech-hackday-november_kafka_1 bash -c \
"kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:${KAFKA_HOST_PORT} --topic ${TOPIC_TO_CHECK} --time -1" | awk -F: '{print $NF}'| tr -d '[:space:]')

echo "Expecting ${EXPECTED_COUNT} messages in topic ${TOPIC_TO_CHECK}"

if [ "$ACTUAL_COUNT" -eq $EXPECTED_COUNT ]; then
  echo "Messages successfully produced by connector"
else
  echo "Something went wrong"
  exit 1
fi

docker-compose -f ../../../docker-compose.yml down -v
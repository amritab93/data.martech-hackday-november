#!/bin/bash
set -e

EXPECTED_COUNT=1

ACTUAL_COUNT=$(docker-compose -f . docker-compose.yml exec -T kafka \
  kafka-console-consumer --timeout-ms 5000 \
  --offset latest \
  --bootstrap-server localhost:"$KAFKA_HOST_PORT" \
  --topic "$TOPIC_TO_CHECK")

echo "Expecting ${COUNT} messages in topic ${TOPIC_TO_CHECK}"

if [[ ${ACTUAL_COUNT} -eq "${EXPECTED_COUNT}" ]]
then
  echo "Message successfully produced by connector"
else
  echo "Something went wrong"
  return 1
fi

docker-compose -f ./docker-compose.yml down -v
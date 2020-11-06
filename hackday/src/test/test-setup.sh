#!/bin/bash
set -e

export KAFKA_CONNECT_URL="http://localhost:8083"
export TOPIC_TO_CHECK="placeholder"
export KAFKA_HOST_PORT=9092

docker-compose up -d

#wait until services are up
sleep 15

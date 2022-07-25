#!/bin/bash
while true; do
    date >> /app/insights/microservices/crypto/RAM/RAM.log
    docker stats --no-stream >> /app/insights/microservices/crypto/RAM/RAM.log
    sleep 300
done

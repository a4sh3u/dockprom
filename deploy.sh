#!/bin/sh
set -e

if [ -f ./prometheus/prometheus.yml ]; then
  rm -f ./prometheus/prometheus.yml
fi

. ./.env
envsubst < "./prometheus/prometheus_template.yml" > "./prometheus/prometheus.yml"
docker-compose up -d
docker-compose ps

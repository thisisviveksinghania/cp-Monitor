#!/usr/bin/bash

echo "--------------Down the Kafka cluster--------------"
docker compose down -v

echo ""
echo ""
echo "--------------Delete Kube Prometheus Stack--------------"
helm uninstall prometheus

echo ""
echo ""
echo "--------------Delete Kind cluster--------------"
kind delete cluster
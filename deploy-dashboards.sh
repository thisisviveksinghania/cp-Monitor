#!/usr/bin/bash

echo "--------------Import Kafka Cluster dashboard--------------" 
curl -X POST http://localhost:3000/api/dashboards/db -u admin:$GRAFANA_PASSWORD -H 'Content-Type: application/json' -H 'Accept: application/json' -d '@kafka-cluster-deploy.json'

echo ""
echo "--------------Import Kafka Topics dashboard--------------" 
curl -X POST http://localhost:3000/api/dashboards/db -u admin:$GRAFANA_PASSWORD -H 'Content-Type: application/json' -H 'Accept: application/json' -d '@kafka-topics-deploy.json'

echo ""
echo "--------------Import Zookeeper Cluster dashboard--------------" 
curl -X POST http://localhost:3000/api/dashboards/db -u admin:$GRAFANA_PASSWORD -H 'Content-Type: application/json' -H 'Accept: application/json' -d '@zookeeper-cluster-deploy.json'

echo ""
echo "--------------Import Kafka Connect Cluster dashboard--------------" 
curl -X POST http://localhost:3000/api/dashboards/db -u admin:$GRAFANA_PASSWORD -H 'Content-Type: application/json' -H 'Accept: application/json' -d '@kafka-connect-deploy.json'
#!/usr/bin/bash 

echo "--------------Creating Kind cluster--------------"
kind create cluster

echo ""
echo ""
echo "--------------Add Prometheus community helm repo--------------"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo ""
echo ""
echo "--------------Install Kube Prometheus Stack--------------"
helm install prometheus prometheus-community/kube-prometheus-stack -f values.yaml

echo ""
echo ""
echo "--------------Deploy Kafka Cluster--------------"
docker compose up -d

echo ""
echo ""
echo "--------------Create the Scrape config for the Kafka cluster in prometheus--------------"
kubectl apply -f cp-monitor.yaml

echo ""
echo ""
echo "--------------Get Grafana UI password--------------"
echo "Password: "
password=$(kubectl get secrets prometheus-grafana -o json | grep -o '"admin-password": "[^"]*' | grep -o '[^"]*$' | base64 --decode)
echo $password

echo ""
echo "--------------Checking if Grafana UI is up and running--------------"
readyReplicas=0

while [ $readyReplicas != 1 ];
do
    echo -n "."
    isReady=$(kubectl get deployment prometheus-grafana -o json | grep -o '"availableReplicas": [0-9]*')
    if [ ! -z "$isReady" ]
    then
        readyReplicas=$(expr $(kubectl get deployment prometheus-grafana -o json | grep -o '"readyReplicas": [0-9]*' | grep -o '[0-9]*$'))
        echo ""
        echo "Ready Replicas: $readyReplicas"
    fi
    sleep 2
done

echo "--------------Grafana UI is up and running--------------"

echo ""
echo "Run this command in a new terminal and deploy the dashboards"
echo "export GRAFANA_PASSWORD=$password"


echo ""
echo "--------------Port forward Grafana UI to local port 3000--------------"
kubectl port-forward service/prometheus-grafana 3000:80

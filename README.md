# Kafka JMX Observability with Kube Prometheus Stack

## Pre-requisites

THe following utility should be pre-installed and in the environment PATH

- kind
- kubectl
- helm
- docker

## Setup the Prometheus Grafana Stack

```bash
./start.sh
```

## Deploy the Grafana dashboard

```bash
./deploy-dashboards.sh
```

## Destroy and clean the Stack

```bash
./stop.sh
```
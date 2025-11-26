#!/bin/bash

echo "🔍 Checking monitoring stack status..."
echo "--------------------------------------"

# PROMETHEUS
if systemctl is-active --quiet prometheus; then
    echo "✅ Prometheus: RUNNING"
else
    echo "❌ Prometheus: NOT RUNNING"
fi

# NODE EXPORTER
if systemctl is-active --quiet node_exporter; then
    echo "✅ Node Exporter: RUNNING"
else
    echo "❌ Node Exporter: NOT RUNNING"
fi

# GRAFANA
if systemctl is-active --quiet grafana-server; then
    echo "✅ Grafana: RUNNING"
else
    echo "❌ Grafana: NOT RUNNING"
fi

echo "--------------------------------------"
echo "🌐 URLs:"
echo "Prometheus:      http://localhost:9090"
echo "Node Exporter:   http://localhost:9100/metrics"
echo "Grafana:         http://localhost:3000"
echo "--------------------------------------"

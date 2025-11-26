#!/bin/bash

set -e

NODE_VERSION="1.8.1"
USER="node_exporter"

echo "📥 Downloading Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_VERSION}/node_exporter-${NODE_VERSION}.linux-amd64.tar.gz

echo "📦 Extracting..."
tar -xvf node_exporter-${NODE_VERSION}.linux-amd64.tar.gz
cd node_exporter-${NODE_VERSION}.linux-amd64

echo "👤 Creating user..."
useradd --no-create-home --shell /usr/sbin/nologin ${USER} || true

echo "📄 Copying binary..."
cp node_exporter /usr/local/bin/

echo "🔧 Setting permissions..."
chown ${USER}:${USER} /usr/local/bin/node_exporter

echo "⚙️ Enabling systemd service..."
cp service-node_exporter.service /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

echo "✅ Node Exporter installed!"
echo "👉 Check: http://localhost:9100/metrics"

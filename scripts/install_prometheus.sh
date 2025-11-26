#!/bin/bash

set -e

PROM_VERSION="2.53.0"
USER="prometheus"

echo "📥 Downloading Prometheus..."
wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz

echo "📦 Extracting..."
tar -xvf prometheus-${PROM_VERSION}.linux-amd64.tar.gz
cd prometheus-${PROM_VERSION}.linux-amd64

echo "👤 Creating prometheus user..."
useradd --no-create-home --shell /usr/sbin/nologin ${USER} || true

echo "📁 Creating directories..."
mkdir -p /etc/prometheus /var/lib/prometheus

echo "📄 Copying binaries and configs..."
cp prometheus /usr/local/bin/
cp promtool /usr/local/bin/
cp -r consoles /etc/prometheus/
cp -r console_libraries /etc/prometheus/

# You will place your own prometheus.yml in repository root
cp prometheus.yml /etc/prometheus/

echo "🔧 Setting permissions..."
chown -R ${USER}:${USER} /etc/prometheus /var/lib/prometheus

echo "⚙️ Enabling systemd service..."
cp service-prometheus.service /etc/systemd/system/prometheus.service

systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus

echo "✅ Prometheus installed successfully!"
echo "👉 Visit: http://localhost:9090"

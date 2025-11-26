#!/bin/bash

set -e

echo "📥 Adding Grafana repo..."
apt-get install -y software-properties-common wget gnupg2

wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

echo "📦 Installing Grafana..."
apt-get update -y
apt-get install -y grafana

echo "⚙️ Enabling and starting service..."
systemctl daemon-reload
systemctl enable grafana-server
systemctl start grafana-server

echo "📁 Importing Grafana datasources..."
mkdir -p /etc/grafana/provisioning/datasources
cp datasources.json /etc/grafana/provisioning/datasources/default.yaml

echo "📁 Importing dashboards..."
mkdir -p /etc/grafana/provisioning/dashboards
cp -r dashboards /etc/grafana/provisioning/

echo "🔧 Restarting Grafana..."
systemctl restart grafana-server

echo "✅ Grafana installed!"
echo "👉 Open: http://localhost:3000"
echo "➡ Login: admin / admin"

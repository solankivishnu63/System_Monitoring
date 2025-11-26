Prometheus + Node Exporter + Grafana (No Docker)
<p align="center"> <img src="https://img.shields.io/badge/Prometheus-Monitoring-orange?logo=prometheus"> <img src="https://img.shields.io/badge/Grafana-Dashboards-yellow?logo=grafana"> <img src="https://img.shields.io/badge/Linux-Server-green?logo=linux"> </p>

This repository provides a complete guide and configuration for setting up a Linux monitoring stack without Docker, using:

```bash
Node Exporter → Collect system metrics

Prometheus → Store & scrape metrics

Grafana → Visual dashboards
```

This setup works on any Linux distribution (Ubuntu, Debian, CentOS, RHEL, Fedora, etc.).

🚀 Features

Lightweight, production-ready monitoring stack

CPU, memory, disk, network & hardware metrics via Node Exporter

Prometheus stores and queries metrics

Grafana visualizes detailed dashboards

Works entirely without Docker

Configurable systemd services for automatic startup

📦 Requirements

Linux OS
```
wget, tar, and systemd
```
Port access:
```
9100 – Node Exporter

9090 – Prometheus

3000 – Grafana
```
🛠 Installation Steps (No Docker)
1. Install Node Exporter
Download and extract:
```bash
cd /opt
sudo wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.8.1.linux-amd64.tar.gz
sudo tar -xvf node_exporter-*.tar.gz
sudo mv node_exporter-*/ node_exporter
```

Create system user:

```sudo useradd --no-create-home --shell /bin/false node_exporter```

Create systemd service:
```
sudo tee /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=default.target
EOF

Start and enable:
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
```

2. Install Prometheus
Create user:
```
sudo useradd --no-create-home --shell /bin/false prometheus
```
Download & extract:
```cd /opt
sudo wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-*.linux-amd64.tar.gz
sudo tar -xvf prometheus-*.tar.gz
sudo mv prometheus-*/ prometheus
```

Create directories:
```
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
```

Copy configuration files:
```
sudo cp /opt/prometheus/prometheus.yml /etc/prometheus/
sudo cp /opt/prometheus/consoles/ /etc/prometheus/ -r
sudo cp /opt/prometheus/console_libraries/ /etc/prometheus/ -r
```
Set permissions:
```
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /opt/prometheus
```
3. Prometheus Configuration

Use this minimal prometheus.yml:

```
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:9100"]

```
Save as:

```
/etc/prometheus/prometheus.yml
```
4. Create Prometheus systemd service
```
sudo tee /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/opt/prometheus/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

Restart=always

[Install]
WantedBy=default.target
EOF
```

Start services:
```
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
```
5. Install Grafana
Install repository and package:

```
Ubuntu / Debian

sudo apt-get install -y apt-transport-https software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt update
sudo apt install grafana -y


CentOS / RHEL

sudo tee /etc/yum.repos.d/grafana.repo <<EOF
[grafana]
name=Grafana OSS
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
EOF
sudo yum install grafana -y
```
Start Grafana:
```
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```
📊 Accessing the Monitoring Tools
Tool	URL	Notes
Node Exporter
```
http://localhost:9100/metrics
```
Raw server metrics
Prometheus	
```
http://localhost:9090
```
Query metrics
Grafana
```
http://localhost:3000
Login: admin / admin
```
📘 Grafana Configuration

After login:

Go to Configuration → Data Sources

Add Prometheus

URL → ```http://localhost:9090```

Save & Test

Import recommended dashboards:
Dashboard	ID
Node Exporter Full	1860
Linux System Dashboard	11074
🔍 Usage
Verify Node Exporter is running:
```
systemctl status node_exporter
```
Check Prometheus targets:

Visit:

```http://localhost:9090/targets```

Open Grafana and visualize metrics:
```http://localhost:3000```

🤝 Contributing

Feel free to open PRs for additional exporters, dashboards, or improvements

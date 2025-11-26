📊 Linux Monitoring Setup
Prometheus + Node Exporter + Grafana (No Docker)
<p align="center"> <img src="https://img.shields.io/badge/Linux-Monitoring-0078D4?style=for-the-badge&logo=linux&logoColor=white" /> <img src="https://img.shields.io/badge/Prometheus-Metrics-E6522C?style=for-the-badge&logo=prometheus&logoColor=white" /> <img src="https://img.shields.io/badge/Grafana-Dashboard-F46800?style=for-the-badge&logo=grafana&logoColor=white" /> <img src="https://img.shields.io/badge/Node%20Exporter-System%20Stats-2E8B57?style=for-the-badge" /> <img src="https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" /> </p>

This repository provides a complete Linux server monitoring stack using native binaries and systemd services.

🖼️ Screenshots

Replace the placeholder image links with your actual screenshots.

📈 Grafana Dashboard

📡 Prometheus Targets

💻 Node Exporter Metrics

⚡ One-Click Installer (FULL STACK)

Create a script named install_all.sh, or put this directly in README for users:

```
curl -s https://raw.githubusercontent.com/yourrepo/linux-monitoring/main/scripts/install_all.sh | sudo bash
```


Here is the install_all.sh content (add into your scripts/ folder):

```
#!/bin/bash
echo "🚀 Starting full monitoring stack installation..."

bash scripts/install_prometheus.sh
bash scripts/install_node_exporter.sh
bash scripts/install_grafana.sh

echo "🎉 Installation complete!"
echo "📍 Grafana → http://localhost:3000"
echo "📍 Prometheus → http://localhost:9090"
echo "📍 Node Exporter → http://localhost:9100/metrics"
```


Make it executable:

```
chmod +x scripts/install_all.sh
```
📁 Project Structure
```
📦 linux-monitoring
 ┣ 📄 README.md
 ┣ 📁 prometheus
 ┃ ┣ 📄 prometheus.yml
 ┃ ┗ 📄 service-prometheus.service
 ┣ 📁 node_exporter
 ┃ ┗ 📄 service-node_exporter.service
 ┣ 📁 grafana
 ┃ ┣ 📄 datasources.json
 ┃ ┗ 📁 dashboards
 ┃   ┗ 📄 system-overview.json
 ┗ 📁 scripts
   ┣ 📄 install_prometheus.sh
   ┣ 📄 install_node_exporter.sh
   ┣ 📄 install_grafana.sh
   ┣ 📄 health-check.sh
   ┗ 📄 install_all.sh
```

🛠 Installation (Manual)
1️⃣ Install Prometheus
```
sudo bash scripts/install_prometheus.sh
```

2️⃣ Install Node Exporter
```
sudo bash scripts/install_node_exporter.sh
```
3️⃣ Install Grafana
```
sudo bash scripts/install_grafana.sh
```
🌐 Access URLs
Service	URL
Prometheus	http://localhost:9090

Prometheus Targets	http://localhost:9090/targets

Node Exporter Metrics	http://localhost:9100/metrics

Grafana	http://localhost:3000
🧪 Health Check
```
bash scripts/health-check.sh
```

🙌 Contributing

PRs welcome. Feel free to add dashboards, exporters, or automation scripts.

🛡 License

MIT License — free to use and modify.
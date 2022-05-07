#!/usr/bin/env bash

curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xvzf node_exporter-1.3.1.linux-amd64.tar.gz -C /usr/bin --strip-components=1
cp $HOME/config/node-exporter.service  /etc/systemd/system
systemctl daemon-reload
systemctl enable --now node-exporter
systemctl start node-exporter
#!/bin/bash
set -euo pipefail

sudo yum install wget unzip -y
sudo wget -O consul.zip https://releases.hashicorp.com/consul/0.9.3/consul_0.9.3_linux_amd64.zip?_ga=2.152032953.1230732308.1505739795-602927451.1505739795
sudo unzip consul.zip -d /usr/bin
sudo mkdir -p /etc/consul.d
sudo chmod 0755 /etc/consul.d
sudo mkdir /tmp/logs
sudo chmod 0755 /tmp/logs
self_private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
consul agent -server -data-dir=/tmp/consul -node=consul-${instance_id} -bind=${self_private_ip} -bootstrap-expect=3 -config-dir=/etc/consul.d -ui -client 0.0.0.0 >/tmp/logs/consul-${instance_id}.log 2>&1 &

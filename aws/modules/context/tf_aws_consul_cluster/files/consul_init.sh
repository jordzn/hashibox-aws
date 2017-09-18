#!/bin/bash
set -euo pipefail

yum install wget unzip -y
wget -O consul.zip https://releases.hashicorp.com/consul/0.9.3/consul_0.9.3_linux_amd64.zip?_ga=2.152032953.1230732308.1505739795-602927451.1505739795
unzip consul.zip -d /usr/bin
mkdir -p /etc/consul.d
mkdir /tmp/logs
self_private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
consul agent -server -data-dir=/tmp/consul -node=consul-${instance_id} -bind=${self_private_ip} -bootstrap-expect=3 -config-dir=/etc/consul.d -ui -client 0.0.0.0 >/tmp/logs/consul-${instance_id}.log 2>&1 &

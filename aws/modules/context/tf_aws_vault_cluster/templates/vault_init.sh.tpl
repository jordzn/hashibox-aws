#!/bin/bash
set -euo pipefail

yum install wget unzip -y
wget -O vault.zip https://releases.hashicorp.com/vault/0.8.2/vault_0.8.2_linux_amd64.zip?_ga=2.37379296.1575219777.1505724488-1522196117.1504177107
unzip vault.zip -d /usr/bin
mkdir /etc/vault
touch /etc/vault/vault.hcl
chown root:root /etc/vault/vault.hcl
chmod 0644 /etc/vault/vault.hcl
mkdir /etc/vault/plugins
wget -O vault-plugin-database-oracle https://releases.hashicorp.com/vault-plugin-database-oracle/0.1.0/
mv vault-plugin-database-oracle /etc/vault/plugins
chown root:root /etc/vault/plugins/vault-plugin-database-oracle
chmod 0644 /etc/vault/plugins/vault-plugin-database-oracle
export VAULT_ADDR=http://0.0.0.0:8200
cat <<EOF > /etc/vault/vault.hcl
backend "consul" {
  address = "${consul_ip}:8500"
  scheme = "http"
  path = "vault-ha/"
}

plugin_directory="/etc/vault/plugins"
disable_mlock=true

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}
EOF
mkdir /tmp/logs
sleep 30
vault server -config=/etc/vault/vault.hcl >/tmp/logs/vault.log 2>&1 &

wget -O consul.zip https://releases.hashicorp.com/consul/0.9.3/consul_0.9.3_linux_amd64.zip?_ga=2.152032953.1230732308.1505739795-602927451.1505739795
unzip consul.zip -d /usr/bin
mkdir -p /etc/consul.d
cat <<EOF > /etc/consul.d/vault-leader.json
{
  "check": {
    "name": "vault-leader",
    "script": "export VAULT_ADDR=http://0.0.0.0:8200 && vault status | grep 'Mode: active' > /dev/null",
    "interval": "30s"
  }
}
EOF
self_private_ip=$$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
instance_id=$$(curl http://169.254.169.254/latest/meta-data/instance-id)
consul agent -data-dir=/etc/consul.d -node=vault-$${instance_id} -bind=$${self_private_ip} -config-dir=/etc/consul.d &>/dev/null &
sleep 5
consul join ${consul_ip}

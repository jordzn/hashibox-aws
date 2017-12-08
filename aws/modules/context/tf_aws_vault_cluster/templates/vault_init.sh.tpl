#!/bin/bash
set -euo pipefail

sudo yum install wget unzip -y
wget -O vault.zip https://releases.hashicorp.com/vault/0.8.2/vault_0.8.2_linux_amd64.zip?_ga=2.37379296.1575219777.1505724488-1522196117.1504177107
sudo unzip vault.zip -d /usr/bin
sudo mkdir /etc/vault
sudo chmod 0755 /etc/vault
touch /etc/vault/vault.hcl
sudo chown root:root /etc/vault/vault.hcl
sudo chmod 0644 /etc/vault/vault.hcl
sudo mkdir /etc/vault/plugins
wget -O vault-plugin-database-oracle.zip https://releases.hashicorp.com/vault-plugin-database-oracle/0.1.1/vault-plugin-database-oracle_0.1.1_linux_amd64.zip
unzip vault-plugin-database-oracle.zip -d /etc/vault/plugins
sudo chown root:root /etc/vault/plugins/vault-plugin-database-oracle
sudo chmod 0744 /etc/vault/plugins/vault-plugin-database-oracle
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
sudo mkdir /tmp/logs
sudo chmod 0755 /tmp/logs
sleep 30
vault server -config=/etc/vault/vault.hcl >/tmp/logs/vault.log 2>&1 &

wget -O consul.zip https://releases.hashicorp.com/consul/0.9.3/consul_0.9.3_linux_amd64.zip?_ga=2.152032953.1230732308.1505739795-602927451.1505739795
unzip consul.zip -d /usr/bin
sudo mkdir -p /etc/consul.d
sudo chmod 0755 /etc/consul.d
cat <<EOF > /etc/consul.d/vault-leader.json
{
  "check": {
    "name": "vault-leader",
    "script": "export VAULT_ADDR=http://0.0.0.0:8200 && vault status | grep 'Mode: active' > /dev/null",
    "interval": "30s"
  }
}
EOF

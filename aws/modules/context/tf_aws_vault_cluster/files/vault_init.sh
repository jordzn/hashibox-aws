#!/bin/bash
set -euo pipefail

yum install wget unzip -y
wget -O vault.zip https://releases.hashicorp.com/vault/0.8.2/vault_0.8.2_linux_amd64.zip?_ga=2.37379296.1575219777.1505724488-1522196117.1504177107
unzip vault.zip -d /usr/bin
mkdir /etc/vault
touch /etc/vault/vault.hcl
chown root:root /etc/vault/vault.hcl
chmod 0644 /etc/vault/vault.hcl
export VAULT_ADDR=http://0.0.0.0:8200
cat <<EOF > /etc/vault/vault.hcl
backend "consul" {
  address = "x:8500"
  scheme = "http"
  path = "vault-ha/"
}

disable_mlock=true

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}
EOF
#vault server -config=/etc/vault/vault.hcl &>/tmp/logs/vault-$1.log &

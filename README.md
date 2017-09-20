# oracle-vault (Under Construction)
A Terraform repository capable of building HA HashiCorp Vault into AWS, integrating with Oracle (RDS).

This repository can be used to spin up a HA Vault cluster backed by Consul, on-demand.

This is not a production ready implementation - purely for demo purposes.

Core modules: https://github.com/terraform-community-modules

Context modules: me

## Pre-reqs:
- AWS account
- AWS SSH key pair available, present in both AWS and the local shell
- Exported Access/Secret keys in the current shell
- Terraform installed
- Internet connection

## Instructions:
1. `cd aws/workspaces/demo`
2. `terraform get`
3. `terraform plan`
3. `terraform apply` (fill out variables appropriately - easiest approach is to use default networking resource in your AWS account)

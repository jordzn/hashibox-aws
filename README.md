# HashiBox - AWS
A Terraform repository, with a well-tested structure, capable of providing a HashiCorp tool playground in AWS.

This repository can be used to spin up a HA Vault cluster backed by Consul, on-demand and to explore HashiCorp Vault and Consul.

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

2. Create a `terraform.tfvars` in the current directory, similar to the example below:
```
ami_id           = "ami-xxxxx"
subnet_id        = "subnet-xxxxx"
aws_region       = "eu-west-1"
key_name         = "active_key_in_aws"
private_key_path = "/local/path/.ssh/to_active_key_in/aws.pem"
vpc_id           = "vpc-xxxxx"
```

3. `terraform get` (for local state) / `terraform init` (if using remote state - see 'Using remote state' below)

4. `terraform plan`

5. `terraform apply`


## Using remote state and locking:
This section before running any of the instructions above if a remote-state approach to Terraform is desired.

1. `cd aws/workspaces/account_management/tf_prep`

2. Create a `terraform.tfvars` in the current directory, similar to the example below:
```
tf_state_bucket_name = "example-string"
```

3. `terraform plan`

4. `terraform apply`

5. `cd ../../demo`

6. `vi backend.tf` and uncomment the 'backend' section, fill it out appropriately according to the backend resources created in 5.

7. Continue on to the instructions above...


## Contributions
Fork and pull-request into this repository please guys!


## Contact
jordan.taylor@contino.io

# provider vars
variable "aws_region" {}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "ami_id" {
  description = "The AMI to use"
}

variable "key_name" {}

variable "private_key_path" {}

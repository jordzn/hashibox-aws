# provider vars
variable "aws_access_key" {
    default = ""
}
variable "aws_secret_key" {
    default = ""
}
variable "aws_region" {
    default = ""
}

# consul vars
variable "instance_name" {
  description = "Used to populate the Name tag. This is done in main.tf"
  default     = "consul"
}

variable "instance_type" {
  default = "t2.small"
}

variable "private_key_path" {}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "security_group_ids" {
  description = "The IDs of security groups to attach to"
  type        = "list"
  default     = []
}

variable "ami_id" {
  description = "The AMI to use"
}

variable "number_of_instances" {
  description = "number of instances to make"
  default = 3
}

variable "user_data" {
  description = "The path to a file with user_data for the instances"
  default     = "consul_init.sh"
}

variable "key_name" {}

variable "tags" {
  default = {
    created_by = "terraform"
    role       = "service-discovery"
 }
}

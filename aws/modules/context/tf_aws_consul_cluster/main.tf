module "consul_cluster" {
  source              = "../../core/tf_aws_ec2_instance"
  instance_type       = "${var.instance_type}"
  instance_name       = "${var.instance_name}"
  key_name            = "${var.key_name}"
  ami_id              = "${var.ami_id}"
  aws_region          = "${var.aws_region}"
  subnet_id           = "${var.subnet_id}"
  number_of_instances = "${var.number_of_instances}"
  user_data           = "${path.module}/files/${var.user_data}"
  aws_access_key      = "${var.aws_access_key}"
  aws_secret_key      = "${var.aws_secret_key}"
  aws_region          = "${var.aws_region}"
}

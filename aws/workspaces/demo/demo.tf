module "vault_cluster" {
  source     = "../../modules/context/tf_aws_vault_cluster"
  ami_id     = "${var.ami_id}"
  key_name   = "${var.key_name}"
  subnet_id  = "${var.subnet_id}"
  aws_region = "${var.aws_region}"
}

module "consul_cluster" {
  source     = "../../modules/context/tf_aws_consul_cluster"
  ami_id     = "${var.ami_id}"
  key_name   = "${var.key_name}"
  subnet_id  = "${var.subnet_id}"
  aws_region = "${var.aws_region}"
}

module "vault_cluster" {
  source     = "../../modules/context/tf_aws_vault_cluster"
  ami_id     = "${var.ami_id}"
  subnet_id  = "${var.subnet_id}"
  aws_region = "${var.aws_region}"
}

// module "vault_cluster" {
//   source              = "../../modules/context/tf_aws_vault_cluster"
//   #ami_id              = "${var.ami_id}"
//   #subnet_id           = "${var.subnet_id}"
// }

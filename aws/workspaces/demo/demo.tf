module "vault_cluster" {
  source             = "../../modules/context/tf_aws_vault_cluster"
  ami_id             = "${var.ami_id}"
  key_name           = "${var.key_name}"
  subnet_id          = "${var.subnet_id}"
  aws_region         = "${var.aws_region}"
  private_key_path   = "${var.private_key_path}"
  consul_ip          = "${element(module.consul_cluster.consul_cluster_instance_priv_ips, 0)}"
  security_group_ids = [ "${module.demo_common_sg.this_security_group_id}",
                         "${module.demo_consul_cluster_sg.this_security_group_id}" ]
}

module "consul_cluster" {
  source             = "../../modules/context/tf_aws_consul_cluster"
  ami_id             = "${var.ami_id}"
  key_name           = "${var.key_name}"
  subnet_id          = "${var.subnet_id}"
  aws_region         = "${var.aws_region}"
  private_key_path   = "${var.private_key_path}"
  security_group_ids = [ "${module.demo_common_sg.this_security_group_id}",
                         "${module.demo_consul_cluster_sg.this_security_group_id}" ]
}

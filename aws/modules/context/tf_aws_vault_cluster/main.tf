data "template_file" "vault_init" {
  template = "${file("${path.module}/templates/vault_init.sh.tpl")}"

  vars {
    consul_ip = "${var.consul_ip}"
  }
}

module "vault_cluster" {
  source              = "../../core/tf_aws_ec2_instance"
  instance_type       = "${var.instance_type}"
  instance_name       = "${var.instance_name}"
  key_name            = "${var.key_name}"
  ami_id              = "${var.ami_id}"
  aws_region          = "${var.aws_region}"
  subnet_id           = "${var.subnet_id}"
  security_group_ids  = "${var.security_group_ids}"
  number_of_instances = "${var.number_of_instances}"
  user_data           = "${data.template_file.vault_init.rendered}"
  aws_access_key      = "${var.aws_access_key}"
  aws_secret_key      = "${var.aws_secret_key}"
  aws_region          = "${var.aws_region}"
}

resource "null_resource" "consul_join" {
  count = "${var.number_of_instances}"
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", module.vault_cluster.ec2_instance_ids)}"
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host        = "${element(module.vault_cluster.instance_public_ips, count.index)}"
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("${var.private_key_path}")}"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    inline = [
      "sleep 60",
      "consul agent -data-dir=/etc/consul.d -node=vault-${element(module.vault_cluster.ec2_instance_ids, count.index)} -bind=${element(module.vault_cluster.instance_private_ips, count.index)} -config-dir=/etc/consul.d -enable-script-checks=true >/tmp/logs/consul.log 2>&1 &",
      "sleep 60",
      "consul join ${var.consul_ip}",
    ]
  }
}

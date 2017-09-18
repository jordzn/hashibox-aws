output "vault_cluster_instance_ids" {
  value = "${vault_cluster.ec2_instance.*.id}"
}

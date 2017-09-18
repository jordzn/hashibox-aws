output "vault_cluster_instance_ids" {
  value = [ "${module.vault_cluster.ec2_instance_id}" ]
}

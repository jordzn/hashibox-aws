output "vault_instance_ids" {
  value = [ "${module.vault_cluster.vault_cluster_instance_ids}" ]
}

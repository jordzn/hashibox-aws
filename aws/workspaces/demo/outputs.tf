output "vault_instance_ids" {
  value = [ "${module.vault_cluster.vault_cluster_instance_ids}" ]
}

output "consul_instance_ids" {
  value = [ "${module.consul_cluster.consul_cluster_instance_ids}" ]
}

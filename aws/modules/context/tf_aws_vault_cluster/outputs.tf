output "vault_cluster_instance_ids" {
  value = [ "${module.vault_cluster.ec2_instance_ids}" ]
}

output "vault_cluster_instance_priv_ips" {
  value = [ "${module.vault_cluster.instance_private_ips}" ]
}

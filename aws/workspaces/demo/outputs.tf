output "consul_instance_ids" {
  value = [ "${module.consul_cluster.consul_cluster_instance_ids}" ]
}

output "vault_instance_ids" {
  value = [ "${module.vault_cluster.vault_cluster_instance_ids}" ]
}

output "consul_cluster_priv_ips" {
  value = [ "${module.consul_cluster.consul_cluster_instance_priv_ips}" ]
}

output "vault_cluster_priv_ips" {
  value = [ "${module.vault_cluster.vault_cluster_instance_priv_ips}" ]
}

output "consul_cluster_pub_ips" {
  value = [ "${module.consul_cluster.consul_cluster_instance_pub_ips}" ]
}

output "vault_cluster_pub_ips" {
  value = [ "${module.vault_cluster.vault_cluster_instance_pub_ips}" ]
}

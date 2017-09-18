output "consul_cluster_instance_ids" {
  value = [ "${module.consul_cluster.ec2_instance_ids}" ]
}

output "consul_cluster_instance_priv_ips" {
  value = [ "${module.consul_cluster.instance_private_ips}" ]
}

output "consul_cluster_instance_pub_ips" {
  value = [ "${module.consul_cluster.instance_public_ips}" ]
}

output "consul_cluster_instance_ids" {
  value = [ "${module.consul_cluster.ec2_instance_id}" ]
}

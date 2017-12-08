module "demo_consul_cluster_sg" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group"
  name        = "demo-consul-cluster-sg"
  description = "Security group for Consul in AWS (Risky, open CIDR, change appropriately during implementation)"
  vpc_id      = "${var.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "consul-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-webui-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-dns-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-dns-udp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-lan-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-lan-udp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-wan-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-wan-udp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "consul-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-webui-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-dns-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-dns-udp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-lan-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-lan-udp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-wan-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "consul-serf-wan-udp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "demo_common_sg" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group"
  name        = "demo-common-sg"
  description = "Security group for providing SSH access in AWS"
  vpc_id      = "${var.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Very open SSH example"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 1
      to_port     = 65535
      protocol    = "tcp"
      description = "Very open SSH example"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

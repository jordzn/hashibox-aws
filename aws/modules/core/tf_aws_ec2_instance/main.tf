// Provider specific configs
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

// EC2 Instance Resource for Module
resource "aws_instance" "ec2_instance" {
    ami             = "${var.ami_id}"
    count           = "${var.number_of_instances}"
    key_name        = "${var.key_name}"
    subnet_id       = "${var.subnet_id}"
    instance_type   = "${var.instance_type}"
    user_data       = "${var.user_data}"
    security_groups = [ "${var.security_group_ids}" ]
    tags {
        Creator  = "${lookup(var.tags,"created_by")}"
        Name        = "${var.instance_name}-${count.index}"
    }
}

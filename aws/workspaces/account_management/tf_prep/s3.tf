resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "${var.tf_state_bucket_name}"
  acl    = "private"
}

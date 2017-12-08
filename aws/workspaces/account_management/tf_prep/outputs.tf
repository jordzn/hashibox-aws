output "dynamodb_table_id" {
  value = "${aws_dynamodb_table.tf_state_locks.id}"
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.tf_state_bucket.id}"
}

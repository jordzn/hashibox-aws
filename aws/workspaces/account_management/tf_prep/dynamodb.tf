resource "aws_dynamodb_table" "tf_state_locks" {
  name           = "terraform-state-locks"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

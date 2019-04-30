resource "aws_kms_key" "test-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "test-key-alias" {
  name          = "alias/${var.application_name}-test"
  target_key_id = "${aws_kms_key.test-key.id}"
}

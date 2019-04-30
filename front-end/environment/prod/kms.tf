resource "aws_kms_key" "prod-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "prod-key-alias" {
  name          = "alias/${var.application_name}-prod"
  target_key_id = "${aws_kms_key.prod-key.id}"
}

resource "aws_kms_key" "dev-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "dev-key-alias" {
  name          = "alias/${var.application_name}-dev"
  target_key_id = "${aws_kms_key.dev-key.id}"
}

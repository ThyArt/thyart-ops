resource "aws_kms_key" "dev-key" {
  enable_key_rotation = true
}

resource "aws_kms_key" "test-key" {
  enable_key_rotation = true
}

resource "aws_kms_key" "prod-key" {
  enable_key_rotation = true
}

resource "aws_kms_alias" "dev-key-alias" {
  name          = "alias/${var.application_name}-dev"
  target_key_id = "${aws_kms_key.dev-key.id}"
}

resource "aws_kms_alias" "test-key-alias" {
  name          = "alias/${var.application_name}-test"
  target_key_id = "${aws_kms_key.dev-key.id}"
}

resource "aws_kms_alias" "prod-key-alias" {
  name          = "alias/${var.application_name}-prod"
  target_key_id = "${aws_kms_key.dev-key.id}"
}

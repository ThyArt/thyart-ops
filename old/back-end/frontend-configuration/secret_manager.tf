resource "aws_secretsmanager_secret" "dev-secret" {
  name       = "${var.application_name}-dev-front-end-cfg"
  kms_key_id = "${aws_kms_key.dev-key.id}"
}

resource "aws_secretsmanager_secret" "test-secret" {
  name       = "${var.application_name}-test-front-end-cfg"
  kms_key_id = "${aws_kms_key.test-key.id}"
}

resource "aws_secretsmanager_secret" "prod-secret" {
  name       = "${var.application_name}-prod-front-end-cfg"
  kms_key_id = "${aws_kms_key.prod-key.id}"
}

resource "aws_secretsmanager_secret" "dev-secret" {
  name       = "${var.application_name}-dev-front-end-configuration"
  kms_key_id = "${aws_kms_key.dev-key.id}"
}

resource "aws_secretsmanager_secret_version" "dev-secret-version" {
  secret_id     = "${aws_secretsmanager_secret.dev-secret.id}"
  secret_string = "${jsonencode(local.front-end-configuration)}"
}

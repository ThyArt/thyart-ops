resource "aws_secretsmanager_secret" "test-secret" {
  name       = "${var.application_name}-test-front-end-configuration"
  kms_key_id = "${aws_kms_key.test-key.id}"
}

resource "aws_secretsmanager_secret_version" "test-secret-version" {
  secret_id     = "${aws_secretsmanager_secret.test-secret.id}"
  secret_string = "${jsonencode(local.front-end-configuration)}"
}

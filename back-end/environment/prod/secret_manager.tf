resource "aws_secretsmanager_secret" "prod-secret" {
  name       = "${var.application_name}-prod-front-end-configuration"
  kms_key_id = "${aws_kms_key.prod-key.id}"
}

resource "aws_secretsmanager_secret_version" "prod-secret-version" {
  secret_id     = "${aws_secretsmanager_secret.prod-secret.id}"
  secret_string = "${jsonencode(local.front-end-configuration)}"
}

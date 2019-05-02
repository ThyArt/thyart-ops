resource "aws_secretsmanager_secret_version" "prod-secret-version" {
  secret_id     = "${data.aws_secretsmanager_secret.prod-secret-manager.id}"
  secret_string = "${jsonencode(local.front-end-configuration)}"
}


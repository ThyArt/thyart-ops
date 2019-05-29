resource "aws_secretsmanager_secret_version" "dev-secret-version" {
  secret_id     = "${data.aws_secretsmanager_secret.dev-secret-manager.id}"
  secret_string = "${jsonencode(local.front-end-configuration)}"
}

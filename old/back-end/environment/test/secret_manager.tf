resource "aws_secretsmanager_secret_version" "test-secret-version" {
  secret_id     = "${data.aws_secretsmanager_secret.test-secret-manager.id}"
  secret_string = "${jsonencode(local.front-end-configuration)}"
}

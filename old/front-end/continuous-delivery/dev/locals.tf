locals {
  backend-connection-json = "${jsondecode(data.aws_secretsmanager_secret_version.frontend-dev-secret-version.secret_string)}"
}


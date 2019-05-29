locals {

  backend-prod-connection-json = "${jsondecode(data.aws_secretsmanager_secret_version.frontend-prod-secret-version.secret_string)}"
  backend-test-connection-json = "${jsondecode(data.aws_secretsmanager_secret_version.frontend-test-secret-version.secret_string)}"
}


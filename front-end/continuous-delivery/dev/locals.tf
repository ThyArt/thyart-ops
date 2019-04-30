locals {

  backend-connection-json = "${jsondecode(data.aws_secretsmanager_secret_version.frontend-dev-secret-version.secret_string)}"

  backend-connection-variables = {
    api-endpoint  = "${local.backend-connection-json["api-endpoint"]}"
    client-secret = "${local.backend-connection-json["client-id"]}"
    client-id     = "${local.backend-connection-json["client-secret"]}"
  }
}

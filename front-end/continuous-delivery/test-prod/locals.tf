locals {
  backend-connection-variables = "${data.external.json.result}"
}

// For Terraform O.12 release
//locals {
//
//  backend-connection-json = "${jsondecode(data.aws_secretsmanager_secret_version.frontend-test-prod-secret-version.secret_string)}"
//
//  backend-connection-variables = {
//    api-endpoint  = "${local.backend-connection-json["api-endpoint"]}"
//    client-secret = "${local.backend-connection-json["client-id"]}"
//    client-id     = "${local.backend-connection-json["client-secret"]}"
//  }
//}


data aws_caller_identity "current" {}

data aws_codecommit_repository "codecommit-repository" {
  repository_name = "thyart-web"
}

data "aws_s3_bucket" "codepipeline-bucket" {
  bucket = "${var.application_name}-codepipeline"
}

data "aws_secretsmanager_secret" "frontend-dev-secret" {
  name = "thyart-api-dev-front-end-configuration"
}

data "aws_secretsmanager_secret_version" "frontend-dev-secret-version" {
  secret_id = "${data.aws_secretsmanager_secret.frontend-dev-secret.id}"
}

data "external" "json" {
  program = ["echo", "${data.aws_secretsmanager_secret_version.frontend-dev-secret-version.secret_string}"]
}

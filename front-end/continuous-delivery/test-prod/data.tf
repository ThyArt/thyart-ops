data aws_caller_identity "current" {}

data aws_codecommit_repository "codecommit-repository" {
  repository_name = "thyart-web"
}

data "aws_s3_bucket" "codebuild-bucket" {
  bucket = "${var.application_name}-codebuild"
}

data "aws_s3_bucket" "codepipeline-bucket" {
  bucket = "${var.application_name}-codepipeline"
}

data "aws_secretsmanager_secret" "frontend-test-secret" {
  name = "${var.backend_name}-test-front-end-cfg"
}

data "aws_secretsmanager_secret" "frontend-prod-secret" {
  name = "${var.backend_name}-prod-front-end-cfg"
}

data "aws_secretsmanager_secret_version" "frontend-test-secret-version" {
  secret_id = "${data.aws_secretsmanager_secret.frontend-test-secret.id}"
}

data "aws_secretsmanager_secret_version" "frontend-prod-secret-version" {
  secret_id = "${data.aws_secretsmanager_secret.frontend-prod-secret.id}"
}

data "external" "test-json" {
  program = ["echo", "${data.aws_secretsmanager_secret_version.frontend-test-secret-version.secret_string}"]
}

data "external" "prod-json" {
  program = ["echo", "${data.aws_secretsmanager_secret_version.frontend-prod-secret-version.secret_string}"]
}

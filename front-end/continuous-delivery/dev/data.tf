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

data "aws_secretsmanager_secret" "frontend-dev-secret" {
  name = "${var.backend_name}-dev-front-end-cfg"
}

data "aws_secretsmanager_secret_version" "frontend-dev-secret-version" {
  secret_id = "${data.aws_secretsmanager_secret.frontend-dev-secret.id}"
}
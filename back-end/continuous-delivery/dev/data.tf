data "aws_ecr_repository" "ecr-repository" {
  name = "${var.codebuild_image_name}"
}

data "aws_caller_identity" "current" {}

data "aws_codecommit_repository" "codecommit-repository" {
  repository_name = "thyart-api"
}

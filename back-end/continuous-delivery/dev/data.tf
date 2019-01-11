data "aws_ecr_repository" "codebuild-repository" {
  name = "${var.codebuild_image_name}"
}

data "aws_caller_identity" "current" {}

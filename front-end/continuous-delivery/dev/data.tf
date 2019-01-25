data aws_caller_identity "current" {}

data aws_codecommit_repository "codecommit-repository" {
  repository_name = "thyart-web"
}

data "aws_s3_bucket" "s3-static-website-bucket" {
  bucket = "${var.application_name}-dev"
}
resource aws_s3_bucket "dev-codebuild-bucket" {
  bucket        = "${var.application_name}-dev-codebuild"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket" "dev-codepipeline-bucket" {
  bucket        = "${var.application_name}-dev-codepipeline"
  acl           = "private"
  force_destroy = true
}

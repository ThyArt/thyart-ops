resource "aws_s3_bucket" "dev-codebuild-bucket" {
  bucket = "${var.application_name}-dev-codebuild"
  acl    = "private"
}

resource "aws_s3_bucket" "prod-image-bucket" {
  bucket        = "${var.application_name}-prod-images"
  acl           = "public-read"
  force_destroy = "true"
}

resource "aws_s3_bucket" "dev-image-bucket" {
  bucket        = "${var.application_name}-dev-images"
  acl           = "public-read"
  force_destroy = "true"
}

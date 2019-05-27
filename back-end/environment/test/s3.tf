resource "aws_s3_bucket" "test-image-bucket" {
  bucket        = "${var.application_name}-test-images"
  acl           = "public-read"
  force_destroy = "true"
}

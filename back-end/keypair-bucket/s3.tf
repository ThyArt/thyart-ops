resource "aws_s3_bucket" "keypair-bucket" {
  bucket        = "${var.application_name}-keypair"
}

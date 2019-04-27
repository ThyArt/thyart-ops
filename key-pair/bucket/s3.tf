resource "aws_s3_bucket" "key-pair-bucket" {
  bucket = "${var.bucket_name}"
}

resource "aws_s3_bucket_object" "backend-dev-ssh-key" {
  bucket  = "${aws_s3_bucket.key-pair-bucket.bucket}"
  key     = "${var.backend_name}-dev.pem"
  content = "${tls_private_key.backend-dev-private-key.private_key_pem}"
}

resource "aws_s3_bucket" "key-pair-bucket" {
  bucket = "${var.bucket_name}"
}

resource "aws_s3_bucket_object" "monitoring-agent-ssh-key" {
  bucket  = "${aws_s3_bucket.key-pair-bucket.bucket}"
  key     = "${var.monitoring_agent_key_pair_name}.pem"
  content = "${tls_private_key.monitoring-agent-private-key.private_key_pem}"
}

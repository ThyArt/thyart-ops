resource "aws_key_pair" "monitoring-agent-key-pair" {
  key_name   = "${var.backend_name}-dev"
  public_key = "${tls_private_key.backend-dev-private-key.public_key_openssh}"
}

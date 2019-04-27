resource "aws_key_pair" "monitoring-agent-key-pair" {
  key_name   = "${var.monitoring_agent_key_pair_name}"
  public_key = "${tls_private_key.monitoring-agent-private-key.public_key_openssh}"
}

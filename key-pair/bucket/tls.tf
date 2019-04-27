resource "tls_private_key" "monitoring-agent-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

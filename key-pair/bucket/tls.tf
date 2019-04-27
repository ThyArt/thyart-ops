resource "tls_private_key" "backend-dev-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

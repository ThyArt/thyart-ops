resource "tls_private_key" "backend-dev-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "backend-test-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "backend-prod-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "frontend-dev-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "frontend-test-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "frontend-prod-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "backend-dev-key-pair" {
  key_name   = "${var.backend_name}-dev"
  public_key = "${tls_private_key.backend-dev-private-key.public_key_openssh}"
}

resource "aws_key_pair" "backend-test-key-pair" {
  key_name   = "${var.backend_name}-test"
  public_key = "${tls_private_key.backend-test-private-key.public_key_openssh}"
}

resource "aws_key_pair" "backend-prod-key-pair" {
  key_name   = "${var.backend_name}-prod"
  public_key = "${tls_private_key.backend-prod-private-key.public_key_openssh}"
}

resource "aws_key_pair" "frontend-dev-key-pair" {
  key_name   = "${var.frontend_name}-dev"
  public_key = "${tls_private_key.frontend-dev-private-key.public_key_openssh}"
}

resource "aws_key_pair" "frontend-test-key-pair" {
  key_name   = "${var.frontend_name}-test"
  public_key = "${tls_private_key.frontend-test-private-key.public_key_openssh}"
}

resource "aws_key_pair" "frontend-prod-key-pair" {
  key_name   = "${var.frontend_name}-prod"
  public_key = "${tls_private_key.frontend-prod-private-key.public_key_openssh}"
}

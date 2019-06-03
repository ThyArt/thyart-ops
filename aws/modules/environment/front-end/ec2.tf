resource "aws_key_pair" "key_pair" {
  key_name   = "${var.stage}-${var.application_name}"
  public_key = tls_private_key.private_key.public_key_openssh
}
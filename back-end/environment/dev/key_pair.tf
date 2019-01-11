resource "aws_key_pair" "dev-key-pair" {
  key_name   = "${var.application_name}-dev"
  public_key = "${file("${var.ssh_public_key}")}"
}

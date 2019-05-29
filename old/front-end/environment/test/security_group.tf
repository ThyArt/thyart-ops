resource "aws_security_group" "test-environment-security-group" {
  vpc_id      = "${data.aws_vpc.frontend-vpc.id}"
  name        = "${var.application_name}-test"
  description = "${var.application_name}-test security group"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}"
  }
}

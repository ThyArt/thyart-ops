resource "aws_security_group" "environment_security_group" {
  vpc_id      = data.aws_vpc.vpc.id
  name        = "${var.application_name}-${var.stage}"
  description = "${var.application_name}-${var.stage} security group"

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
    Name = var.application_name
  }
}

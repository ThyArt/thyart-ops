resource "aws_security_group" "dev-environment-security-group" {
  vpc_id      = "${data.aws_vpc.backend-vpc.id}"
  name        = "${var.application_name}-dev"
  description = "${var.application_name}-dev security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.application_name}-dev"
  }
}

resource "aws_security_group" "dev-rds-security-group" {
  vpc_id      = "${data.aws_vpc.backend-vpc.id}"
  name        = "rds-${var.application_name}-dev"
  description = "Allow inbound mysql traffic"

  tags {
    Name = "rds-${var.application_name}-dev"
  }
}

resource "aws_security_group_rule" "dev-rule-allow-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.dev-rds-security-group.id}"
  source_security_group_id = "${aws_security_group.dev-environment-security-group.id}"
}

resource "aws_security_group_rule" "dev-rule-allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.dev-rds-security-group.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

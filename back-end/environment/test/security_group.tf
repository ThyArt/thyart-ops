resource "aws_security_group" "test-environment-security-group" {
  vpc_id      = "${data.aws_vpc.backend-vpc.id}"
  name        = "${var.application_name}-test"
  description = "${var.application_name}-test security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.application_name}-test"
  }
}

resource "aws_security_group" "test-rds-security-group" {
  vpc_id      = "${data.aws_vpc.backend-vpc.id}"
  name        = "rds-${var.application_name}-test"
  description = "Allow inbound mysql traffic"

  tags {
    Name = "rds-${var.application_name}-test"
  }
}

resource "aws_security_group_rule" "test-rule-allow-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.test-rds-security-group.id}"
  source_security_group_id = "${aws_security_group.test-environment-security-group.id}"
}

resource "aws_security_group_rule" "test-rule-allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.test-rds-security-group.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

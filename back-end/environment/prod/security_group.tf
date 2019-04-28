resource "aws_security_group" "prod-environment-security-group" {
  vpc_id      = "${data.aws_vpc.backend-vpc.id}"
  name        = "${var.application_name}-prod"
  description = "${var.application_name}-prod security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.application_name}-prod"
  }
}

resource "aws_security_group" "prod-rds-security-group" {
  vpc_id      = "${data.aws_vpc.backend-vpc.id}"
  name        = "rds-${var.application_name}-prod"
  description = "Allow inbound mysql traffic"

  tags {
    Name = "rds-${var.application_name}-prod"
  }
}

resource "aws_security_group_rule" "prod-rule-allow-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.prod-rds-security-group.id}"
  source_security_group_id = "${aws_security_group.prod-environment-security-group.id}"
}

resource "aws_security_group_rule" "prod-rule-allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.prod-rds-security-group.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

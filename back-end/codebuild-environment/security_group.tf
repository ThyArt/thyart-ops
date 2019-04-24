resource "aws_security_group" "codebuild-rds-security-group" {
  vpc_id      = "${aws_vpc.codebuild-vpc.id}"
  name        = "rds-codebuild"
  description = "Allow inbound mysql traffic"

  tags {
    Name = "rds-codebuild"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.codebuild-vpc.id}"

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

  tags {
    Name = "rds-codebuild"
  }
}

resource "aws_security_group_rule" "codebuild-rule-allow-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.codebuild-rds-security-group.id}"
  source_security_group_id = "${aws_security_group.codebuild-rds-security-group.id}"
}

resource "aws_security_group_rule" "codebuild-rule-allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.codebuild-rds-security-group.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

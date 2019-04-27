resource "aws_security_group" "monitoring-agent-environment-security-group" {
  vpc_id      = "${aws_vpc.monitoring-agent-vpc.id}"
  name        = "monitoring-agent"
  description = "monitoring-agent security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "monitoring-agent"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.monitoring-agent-vpc.id}"

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
    Name = "monitoring-agent"
  }
}

resource "aws_security_group_rule" "monitoring-agent-rule-allow-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.monitoring-agent-environment-security-group.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

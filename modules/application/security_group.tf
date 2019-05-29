resource "aws_default_security_group" "default" {
  count  = "${tonumber(replace(replace(var.should_be_created, false, 0), true, 1))}"
  vpc_id = "${aws_vpc.vpc.0.id}"

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

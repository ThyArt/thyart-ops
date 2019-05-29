data "aws_ami" "ec2-ami" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "^amzn2-ami-hvm-(.*)-x86_64-gp2$"

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
